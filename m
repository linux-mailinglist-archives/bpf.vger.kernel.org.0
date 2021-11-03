Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746EC443C12
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 04:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKCEBJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 00:01:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5480 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhKCEBI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 00:01:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LZQ6c023764;
        Tue, 2 Nov 2021 20:58:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/vbviwoZp726lNekCS/rnPSw2f4gSCsPs7qB6rlKpP8=;
 b=R5jjlVtylBqUkK2im0GLt/OCfdAqMzcfF8fwvg9MaDR6ASXLwPfjSuuYon/XEw/YNpaH
 mFitr9zf2bZQZq+OYeiji9x/2LEsvdP7MWmaBwd0iZVE83M4zGZpvjJ0stE9n4S+vjBK
 SDY3ACG+GdM/DH8VTfh50wTAKP7rXg0AzTY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dch1ydu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 20:58:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 20:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nblAS51cWYUdd+tOs/XuwO/YQ0i4IB2KM80iDtx/fdWOQFfl6ABuN4DauDjgh8WFT2NSLkxr6SryncfrwLagrfv/5b85qP731MhzkbuB/zNs2eU85K+o4DPFMwGpwFwkOLrqtjIu1jyl9FxtmM6HTN/juM+Kq64xv4GzqdbLVlrV4jQaaQtlGdEtqLEAbX7Z90sapk5skUKjIXiCIlWYpOjUP1Y/FMNcqu4ukWrIzfqUsv3AMCrI0vMM6Gwk3+qH8wX4bOdE2F2nYabO6TIq2UTlyx6fxHRPVcd1fgTecZ0/saccC9KOR+pHxTT5/ztQ7XRQsoMpmDpYQc7Ot+WBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vbviwoZp726lNekCS/rnPSw2f4gSCsPs7qB6rlKpP8=;
 b=ehVG0aNoeiTw/j+IdT8DzEDv+vL2zqUk+5HvqOa4bia98+AbyQ/FKmScn3Zy8a/iP1WG4UIAuRxajILpm3V+xXP9FPFOrYRUagemu7nd7iZYZOjaJZQKWHvL1CPpoG2cOPNSxJgSRxN2vnel04aY3BBFjQ69kJO4gP/Nvn72T5QCJXtZDvROeG2MpQlc9mXxLKPaLm8Ghc4DjwUhSa2tshU3iQC5wJeWA90s0lB46CgksGL5VYJrb1QjRJx1dne/se9h77zFl0byLVbOwXqfGQcy42gnSmqvyfdTFtDn0jAwX7dktRHRw9nANnUxgUDwjLi48mlBTpaDGUOCc/n1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4920.namprd15.prod.outlook.com (2603:10b6:806:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 03:58:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 03:58:15 +0000
Message-ID: <050ba6c6-c7b2-528c-b616-030b7b14d67e@fb.com>
Date:   Tue, 2 Nov 2021 20:58:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: Question about pointer to forward type
Content-Language: en-US
To:     Hou Tao <houtao1@huawei.com>, Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <c19f223e-2ef5-9f9a-f741-2fcc7d89fef6@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <c19f223e-2ef5-9f9a-f741-2fcc7d89fef6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:deca) by MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.0 via Frontend Transport; Wed, 3 Nov 2021 03:58:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a53c789b-eb3c-4f89-0de6-08d99e7e2a00
X-MS-TrafficTypeDiagnostic: SA1PR15MB4920:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4920C5640FEEE8AF00380A55D38C9@SA1PR15MB4920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gXipm8Daxlrjq/Bt/+54ArMn9AUCL2hhvM7DyRvZvyQPX04r7xo4EHNs446et4KqFtjzM9zVmuh/pS4PlsmGrQDCyCl5ESz0LyZF798idhHZldiQG/TSvxPV+NNVvLxKg4Mft/DtPNBzTyPMrV3jPPvG5veDwEs4Vv5wCMWrwmX850tamOqVyU1+ry+QS9JRcflKZ7Ghwc9hVcgJ0d6BEMLdSAGfaspucDTlTvhdo+skEix46AC2CaoCRMAvpqFQlTHxWbgWOO0hEmOt35AnbFI3FatxNTPhC4Hmstrl9XYOMMoYc/fhyKxhqf87dwj/6Ftbuc4ySRmDtmJXsKV6bsCnB6y6cv2Wwy8rsRQgGXtPoeXy2PlnmUXcvizUh5hOcNhXcivWSsGnUxia4Q1HS0T0ToyJFEQnpSWncsbZEgMcQMAKEik2O/3CINKzWG1UJW1iWIK6EHoOSpudn9IWqngMv5Z4lCgGpqnsNzgqT5jAgPRc+yYHNZjBuWGOfal3Eya81ykrPpjYZXPAPSg5H3sdUgYkhdxL3q57f5S3c7EDOrAM9oyOU9Ey6J/w7Xo0zbb4sjECcnQ1dcvaNiNCG5tws06JYo1L+YE0XJ3npcW4FUY41QUboYlK5re+JoL3OUlt1elJl4zzxQJakOhambVi28UFIV9x7C9GR839K7idEmxs/z7EEdu0/aNzOKOeZSEEYqfFgch92InuB/lIDYQP55jIHIZy05FjmJFQr4AVtw1VaQq1BljQUQwEKRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6636002)(6486002)(186003)(5660300002)(83380400001)(2906002)(508600001)(66476007)(66556008)(4326008)(53546011)(8936002)(54906003)(36756003)(52116002)(2616005)(31686004)(316002)(110136005)(8676002)(66946007)(86362001)(6666004)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNZdlJMY09SWlZIL1dHQnZIMmExNSttQS9oNzZJWGI4emJ6REFLWStkandh?=
 =?utf-8?B?Q2w0eTFaaXpJSkVzR09Ub0xkTjhBVkhROThDbnlzVGF1T3BtNnlkQjRRSlRt?=
 =?utf-8?B?TnhJU1JXYks2ZlRZR0xVUVJyb2FUUnNQbytvSHFqUllhdlhXczVLNHlsdWxz?=
 =?utf-8?B?bkNSRlhxZEJ0UUlpQ0w5Vjl0MUVJdEdqWTR5N3p0cmJRNlFzb3JXQlZncHE3?=
 =?utf-8?B?QzczZ0FiMFpCcnp1dlFiUTJ2RWd2eGFpdmthZzBZeXNodFpFcWpEdVMzRUJ3?=
 =?utf-8?B?NjY1SCtGL3BxSGxJVmNLd05qUkZhZWNyR0FIaEM5SXQrZHBnZkRaeXBLRXBR?=
 =?utf-8?B?NjV3YkpHN2JNcWlYWkNyN0U1dXhvemloRVBiNkZZM3o4M0pMWlk0QWorQ1A4?=
 =?utf-8?B?Wk56TzI3QmJFQTNNWlFvZTJHQmRMVzhrZEJVMEdEbVFpbWhxeTkwUzhvV3NH?=
 =?utf-8?B?Z2llTTc5RGJkWis5ZWo4YklSUVF0VXd3WUNwNVl6RlBJTENlK3Y2RFBURFJD?=
 =?utf-8?B?S04wRWo2UC9FL1BGNFVWTEgwOXNJbHVibjZLMXlhVTQ5a0kvTDlFZFJ3Njd6?=
 =?utf-8?B?emJEUWV3MUtVU2VnY0IzWTFMTUhqaGhlcUcrc0oxTnh5ZTF0Y1V2S3BqbkxU?=
 =?utf-8?B?Q2ZqU1lkdk4xY1FpOUxEbXdjTEMvcDZsNExEeW5zaWxiKys3SFhWb1NUTTd2?=
 =?utf-8?B?bzRUZG1xNzI4dU8vbVBucFpJbXpJT0tON1NrTXgxQStWVUh5UWxtZnhzd3Zx?=
 =?utf-8?B?Q0EvVlNDVU8reGd0ODNJaFVURFAvTEo0ZXI4Nk9YNGMzNi9CbEUxS3ppQ2lN?=
 =?utf-8?B?cE1sSktlK25TRlE0L0I2Y1B5VGhUWG9IMTNVdEE3dXVZYzBtUkFNNUROTTFq?=
 =?utf-8?B?TndnVk15RDBlYVZ2QkxHK0c5RXBITHJ1a2RUcjYvZ0ZjRldSZ1h3cUFjaTN0?=
 =?utf-8?B?UVM5SWdOd293c21rZUFrMDFPWkJrWDU4NUtPcU8yeExTWEhzbG4vRnYvYmRB?=
 =?utf-8?B?bHRrZGhpeGZLYTFMS3dBSFM1Z2pyQkFWK0VGa1Z5Q0dQRnpDaEZtK1JqOTJj?=
 =?utf-8?B?eFFGdVk1bGphbUNQOWkwSFM5bWYvbE9NN28wOElRWDYzYXNvVTRJRks1SDF6?=
 =?utf-8?B?cmo1WEkxTUxTZmZJNWl6WUJsNzlZS0svb1kzcG9RTzQ0OHNqdlkwdVMwWDVt?=
 =?utf-8?B?OXB1ck0wSlNwSDNnVkhPN0RBeHh2TGs2VS9OdG1xQ2Q5WWdCOHBTWXk0eC9z?=
 =?utf-8?B?UkRKOFhsUG1yUEJFaWZ2RkxDWHZYMVhnaGo3TzNjK3RZN01majdsKzdhaTYv?=
 =?utf-8?B?MEtQY0UvbGZBRy9SeGhjQlE3eEVlUTFtbGFORVBCSUhnL0pWUEtQU2Y2UWI0?=
 =?utf-8?B?VEVsT2p2QWFxMU4raHkyK1A4NXJRUEY0N1kvdW9vQTZnaGZ4dDVEbGZvUDRU?=
 =?utf-8?B?ZGNBUWRZUi9nMXcwMldMaTY2ZTgvazd6L0pYdHpNbG0xUm9DQmpMYlpuTWpk?=
 =?utf-8?B?RGVteXNwN3J0aWtLWkVJNVhXcjBpeTVMOENwVjdkTjFmOHRnNVA5WUdyRDJW?=
 =?utf-8?B?ejZWMmUrMTE2bEtFRTZGSDdEWXlxdm96bkVhdjZKUFNJdlFDY01VYUZsRVpa?=
 =?utf-8?B?b0MrYUtZa3JrV3ZyM2I1bnhHL3AxenA1MHU1UUFoRkZ4OEtFQmZQOHFlcVNy?=
 =?utf-8?B?WXUweXBvZ0F2KzdlazIvdGc2UktsR0o3QmYvWDg3eFlTcG4yM0hqbjNnaUNp?=
 =?utf-8?B?SnVXNFJESFhNSitFQXdoaFdvWnh2M2ZtbE4za1N3cE5HOHBuL1RpMk1CRUJB?=
 =?utf-8?B?WmFNQ0NDeGZuampVd2g2d1Fyc1lVbnZ1bUpqN2V3N3VNcW81cm9DelpmTjF4?=
 =?utf-8?B?akwwR0tsMGVidTBTSFNaYnV2YkRTOTdkU01NYjJUK0ZNSi9pQ00xc05UWlRx?=
 =?utf-8?B?bHV4anhVMlo4OVd0M2V2L2IvMHFvUFdLeloySXYxUURKQkRhMUYvL1ZTcTA0?=
 =?utf-8?B?K3hIcGhmNWUzZ3BrZVhvSUgzREJpamlDSkVjWEVZbW83NnZPOUtuOHBpWTBl?=
 =?utf-8?B?bmVaYlZERGk4ZXZPQVVFZEkrbUFEYzYxcDYveWZqakc0cHlkejJIUHNVWVNi?=
 =?utf-8?B?YXo5VEU3ajliSFJKemFpT3FUeFJyVXNKd1BBQ1p6K2dLYVVmVXhNRExRVG85?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a53c789b-eb3c-4f89-0de6-08d99e7e2a00
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 03:58:15.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TWdpNtmHX2aYMHMhDlltKa+4n3lrWZBd/3c8QRf4Chzji3L/7quECY7A3cM7xE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4920
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 7yielcha5Z0m42B0LTWTSTQNikYJ5uww
X-Proofpoint-ORIG-GUID: 7yielcha5Z0m42B0LTWTSTQNikYJ5uww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/15/21 7:22 AM, Hou Tao wrote:
> Hi,
> 
> When adding test case for BPF STRUCT OPS, I got the following error
> during test:
> 
> libbpf: load bpf program failed: Permission denied
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> R1 type=ctx expected=fp
> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
> 0: (b4) w0 = -218893067
> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
> 1: (79) r1 = *(u64 *)(r1 +0)
> func 'test_1' arg0 type FWD is not a struct
> invalid bpf_context access off=0 size=8
> 
> The error is reported from btf_ctx_access(). And the cause is
> the definition of struct bpf_dummy_ops_state is separated from
> the definition of test_1 function:
> 
> test_1 is defined in include/linux/bpf.h
> 
> struct bpf_dummy_ops_state;
> struct bpf_dummy_ops {
>          int (*test_1)(struct bpf_dummy_ops_state *cb);
> }
> 
> bpf_dummy_ops_state is defined in net/bpf/bpf_dummy_struct_ops.c
> 
> struct bpf_dummy_ops_state {
> };
> 
> So arg0 has BTF_KIND_FWD type, and the check in btf_ctx_access() fails.
> The problem can be fixed by moving the definition of bpf_dummy_ops_state
> into include/linux/bpf.h or using a void * instead of
> struct bpf_dummy_ops_state *. But forward declaration is possible under
> STRUCT_OPS scenario, so my question is whether or not it is a known issue
> and is there somebody working on this ?

I suspect this is what happened.
The 'struct bpf_dummy_ops_state' is defined in 
net/bpf/bpf_dummy_struct_ops.c, but this structure is not used in that file
so there is no definition in the bpf_dummy_struct_ops.o dwarf.

Since in the final combined dwarf, there is no "struct 
bpf_dummy_ops_state" definition, dedup won't be able to replace
forward declaration with actual definition. And this caused
your above issue.

It would be good if you can verifier whether this is the case or
not. If bpf_dummy_ops_state definition is in the dwarf, then we
likely have a dedup problem.

> 
> Regards,
> Tao
> 
