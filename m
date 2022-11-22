Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA063348F
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 05:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKVExK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 23:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKVExJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 23:53:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E932A41E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 20:53:08 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALMeI5Z004564;
        Mon, 21 Nov 2022 20:52:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nMW0InBMx3kUXY0LOLEEQ4WcZjim3sgNfJy15o974xw=;
 b=cPdpCkNF1Dr29BihP7TSI7zc2oXTXtDCNKC9YfA8yf4JL0DfNvn68E7M0P6dKQqAZUBW
 C+0KLzl+55VlPyO3gS48RjHwwvH9ahta/OaI7Wy1IcPTK8HcEOAtOTE4XcDlnaHqb4dL
 iH1EojHRSjr00LuZE13dN/rq1isQffiW7SF4Cyt0dHOtaP0o7Hg+MpGmGPKGIqLsZUwp
 J6piNAAVGs802Cu74rhjQdDpXoLCjqIxKLVaq6wzvkemhIzViboZyC51zgvebokJzT9H
 imiPAAEptLAoxfTARH7tStPyY1iWMGESKS75Pvf+FfattuBBIeDcdbhTiFQ7iv00XNf0 xw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m08jf6qmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:52:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSqSEOKd80M4yFt84JzO0QbvRJIU7EkRee2oOZboXkv2Jw9IG/bprV3wgsrvWyUevjttm6BMHcHdn6CkvdC1xH9FvqDJQuJZFg/TZcS3JCTlK5ZHsct8R41vCmF+w6sC5Cv6ZrOewmNL4uqmh6tfFMnTxv/T3p3kCWYOWXEDJgus/K8OdCVAmZCCmhoqDu6yI79bLqjvJPOnro2GIJh1ZviaxmG3eiB7LEf27CdlFC0qs7ztO2RWEKkFKcYeBmfL4h8wcFS2fM8xJv2Nn2p/kYDZQzllnFp6HuOzgbtfndQw9vx/k88P+uzTgsNwLfNFc3toTthpE0ZwLQ/TfpGv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMW0InBMx3kUXY0LOLEEQ4WcZjim3sgNfJy15o974xw=;
 b=l/vYRCITHUXf7zU52YTY8OdhrgKB2m+RH81SV4LzDmtjKr5Kon6G/2p3x9GuHvWX2Ct3f8B+2L4uZ7+lD3TCzCiAvxpU0qVkIRZSs0Rgc4FD8U89a+8UPubMYyJzADlau/u+mF70TnJerhtLQx+4lOBAHESO6YY0fChYy6SBWmljE8KcXgFniM6qc6JZF5ZM2C8Q4+onxkvJR7vlEvnk1omOuCVYHsQkQ46F7Km+O7M3lTbt+kvXrOrg2sLqKs/GM1smfnCI9JzmMXihsVq9mh98eYUArlIE3gZO1w5tKScPfx5hKPAhPZBbPsd3axplPWLkDmphEoaRggfiL0eMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Tue, 22 Nov
 2022 04:52:51 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 04:52:50 +0000
Message-ID: <e727f852-7484-b31f-fb5d-7a4f034fe48e@meta.com>
Date:   Mon, 21 Nov 2022 20:52:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
To:     John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
 <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
 <637c2a6c4b042_18ed92085f@john.notmuch>
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <637c2a6c4b042_18ed92085f@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|BYAPR15MB2998:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a22d1d-6e63-4582-93a3-08dacc4565fe
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULX4eV5UbkrQ+3Ga0jXYftzOUlIfiTdHt/mOXdwvH5ke+eMhXFrFRA/datkkuD9KaONW0NphWowa2wxsXiGurmV/67Kiz3u0vIPZwdquXJiC3mscdQe3puckmHsRp9AvezeLicK9dE9+pmp8ugI0dc6bQfhJRQ28xCdMJBJ8EmX+ge1d1qDPr/f0/PWB7/cq+69wl+HZjgmqhECSmcMShwnBCmb/qXuVIhU0SSAVqLj4HXG8mUAw/R2dr4P7XGZOk0TBiuiRN7LGeoyL4O2Td+aPLoKPtDSf3O6M1TSvjEdlc5BVOT2chIbqG7BNE5+Esmqf7C0Z6WnqzWb45uEYxDLerjBwz4/BCz6afYO/GM+8CCBGXJKVinGdmRUMAXsEV3s9khJA53YUC7yLItuHJl/mibdPvgM9cyV0G3YmwRGsVDkU23/4nIfi6eOskGMyHSQwRxeLCUqyGN7dD0eM3ccc/UkpSticgx/shkz7IB+52l/bPsJ+xa2aFDg7t1LIZoXd+51LRmbatNrY+RETsTWjovBBZumyvj2BH0vHzOTvwZHdgn6c8VYH6gp49qzCt7fFYsHOI1c8NCWZGs2ksfbQy/HPzQ32JhfEQo12fS71s2vR+Orl9SeOLsnQcgkbOtupcAkkP2i5nAFdxN5NNsQgA9E5c681qlg+Dvxau1rAi1Sd2QTzHo0b36QGonXSvYF+fUqPvgAqxVi/ZwlWnBsBdORaB2ySxSmkqIymvhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(6506007)(31686004)(6666004)(38100700002)(53546011)(2906002)(8676002)(36756003)(6512007)(66476007)(4326008)(186003)(2616005)(66556008)(31696002)(110136005)(6486002)(478600001)(86362001)(66946007)(83380400001)(54906003)(8936002)(316002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRycFNRNjNaV1RNbEt6MFNxcG85LzJISExVWUI5UkphL0phTmRNdXRGOW80?=
 =?utf-8?B?ZG1oMHhBaldlb0xMT2lEMlR6Smo0Y0pIcXB0Uk0vVytSbHBYVTJNM1Y0blpF?=
 =?utf-8?B?VmNFYUhLSTlCd09ubUdoc05uOFEzZnFBNGlaQndLdDB5U1QyQnd3L1d3MXBq?=
 =?utf-8?B?UFViWlhXZXNyUWFhT3grdEdtN3BLUjBjeGY3V0lLaFpOZ0FlVWRpVTV6VnlJ?=
 =?utf-8?B?SGd2STZHUVUxUWJSOFZpTHI0bXdtNVBVdGxMUTEzb0ZQdmk3ODFOOVhSLzUr?=
 =?utf-8?B?SHE2Z0UzbUZwOW9jUk9RZzhCanl5VlpPeEFRRW1NSTNqdGJ3YldKem5hc0Fr?=
 =?utf-8?B?cWlKOHdEYkhoTi9QbWx0dWh6YzVIOXFPZWM2U2xGVXBmQmNXUHB1TFFSQWlX?=
 =?utf-8?B?MGZOSW5jMHBMa1NpMXNVbjdNNGxkZzVMUDA0anozOUVzK1V2eSsyR3k0cmJ4?=
 =?utf-8?B?cmw1VUZDVHdLaFBobENYZ2Z2SVR3Q0Q3clFIYkp3MUxrWFFwWDZ0RXpFSVZl?=
 =?utf-8?B?WHJ2WVkvZkF0ZW9yRnh1ZkZTbDdrM0h3K1VrVVR5cEpUakZ2Qzd6N1ltRkIy?=
 =?utf-8?B?K2RZb0N6dFY2aXJUZUxjcVg5MVFSTDVLWUExYTFGR1c2NkRTaGtjMkRJTmlx?=
 =?utf-8?B?Y2FBbW5LdjdUN3RBVFhTRVd4eng0VTd3Z2xIdUpmNGwxVFg1bkJOcVFkcXlW?=
 =?utf-8?B?TGF0YmVvQ241SmR6TG9CaWI1MjZSUE1YWEdYS1pMa1RGazdVRUl4NnpmUjBX?=
 =?utf-8?B?eHE3bmlrN3JmK2t0djVHakpyNFh3NlJNb2JnaFdsVkRvaW1maVBEYm5iWk56?=
 =?utf-8?B?QVJEckVVTzNNRlR0RTBRSjJnYTRyYnp1THFDbVpsZWJCdVRpamo3TEhxMTZs?=
 =?utf-8?B?aUNuTGV4bDhqWUZaTksvbDNpeFlHYm1MK25UMkUzdzlFU1NiMFRUcnFabTNP?=
 =?utf-8?B?NG9tZEtKTzcxVmZnNTM0anpmMHhLb3d0TTZVQ2xtMkVvN3A5UWpySkZHTHFB?=
 =?utf-8?B?TkdTYWcvVGUxQ3ZGMDdvTTN1bHlOZGIrck9BWFMxc1loelR4cG15aHFJUkpP?=
 =?utf-8?B?UGtqWEhwb0tzazVGdW4yUFp6VFlBeHhBbGNYMTB4ME5VQS9ib0I3YUxNVzNK?=
 =?utf-8?B?cE4vWmh6NXhlcTZlZlMzSnF0RXg4YTM5UldaNXd0WUJSbWtlQ2VCcGtPQTU1?=
 =?utf-8?B?SVFMNHpIcEU2ZDlJSDFTc2FOSEs0VjBCOWgvWlJURmVaeEVhU05GU1VVN2tj?=
 =?utf-8?B?M2pvWmViTm9XNU5RYWxnc0VJNXA0aHc3SVBNcEJSbEZFQmh2K0lLZ0hDNEY1?=
 =?utf-8?B?VG0raU5CWk9lRmRueHhDaHhCTEJDSEVuam4wK2pKN2prQVRBQlNiTm5ndjhK?=
 =?utf-8?B?L3ltQnoxYW4xdDlFdEdkbG9tYjRFcFFVMnFodlJ2aThQSHltUlRTT2toVCts?=
 =?utf-8?B?UlVsdDA1MDIvYS9HbHhTY1pFME41aUpVMEdzcFhCcExaUllFRVZOd25BdjRt?=
 =?utf-8?B?WDAvc3lST3E1dWZSQTJPRXc3V3lzV3lHYzFCeGY1ZytsWUd2b0dGeUtBa240?=
 =?utf-8?B?S2tMZUlZRUJTWE9FTXVHZXNsdHl5dmRxSmltbXNudzE2OWpDdnZTU08rNlVu?=
 =?utf-8?B?eWRTRmNDb0VqR2Jvd1V4ZUFRbHY1OGhxaWt4em5yZWV5V3FJTG1rdVVEbnF6?=
 =?utf-8?B?aU13WHNxeVJOTnpkYVdKdmVuMVpiMmREVGNjZENBRG5CWUNnRnZSMkJxSm1j?=
 =?utf-8?B?ZDVqUzhFODYvZnpQOWtxYTF1b3NHZVQ4Q3J0ZVQ3RWZWTWVscTEwT3k0eE54?=
 =?utf-8?B?cnU3QndZekwvUmF1UnptclBOZEU3eHNINGFsanFFV1d5cEdNUExnczFpdm5p?=
 =?utf-8?B?TTlYcWMySkVaTUQvQXJQaVBwbzJKd0Uxa1hGd2doOC83NjBqSTZMVytrQ2d0?=
 =?utf-8?B?T3VKSzFBMWdobDJSVHBEVjhrNjlOcG4veVhzZjd0SzQwNGoyeVRhd095NlZT?=
 =?utf-8?B?QWxVT1BiUWxzc21FVjNEbEVYbGQ0OURybEY5YmhuT3QvZHVWcy9oTTREZVZ5?=
 =?utf-8?B?R2duT28ydWEwN2pKbjdCKzM2N2s0bjBYNmF0QzFPYmp2dTAvSHE3SHNOMVZQ?=
 =?utf-8?B?NjN2V2lGSCtrTlRCRmcrdEthK1hWSmx2a2JPUnZCUzU5U0lHdmhQNy90T3Zl?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a22d1d-6e63-4582-93a3-08dacc4565fe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 04:52:50.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlSFkBZcdRWDCbNZ/uBcqgNv6SaXyAAuIdLx9Ttkz9xtTXe4e3x1m7wLuvCDKfNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-Proofpoint-GUID: q-t3dKY2ATrDIoB8_IsWvpxuSpJOkf8V
X-Proofpoint-ORIG-GUID: q-t3dKY2ATrDIoB8_IsWvpxuSpJOkf8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_02,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/21/22 5:48 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 11/20/22 6:10 PM, John Fastabend wrote:
>>> Yonghong Song wrote:
>>>> Currenty, a non-tracing bpf program typically has a single 'context' argument
>>>> with predefined uapi struct type. Following these uapi struct, user is able
>>>> to access other fields defined in uapi header. Inside the kernel, the
>>>> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
>>>> in short) which can access more information than what uapi header provides.
>>>> To access other info not in uapi header, people typically do two things:
>>>>     (1). extend uapi to access more fields rooted from 'context'.
>>>>     (2). use bpf_probe_read_kernl() helper to read particular field based on
>>>>       kctx.
> 
> [...]
> 
>>>   From myside this allows us to pull in the dev info and from that get
>>> netns so fixes a gap we had to split into a kprobe + xdp.
>>>
>>> If we can get a pointer to the recv queue then with a few reads we
>>> get the hash, vlan, etc. (see timestapm thread)
>>
>> Thanks, John. Glad to see it is useful.
>>
>>>
>>> And then last bit is if we can get a ptr to the net ns list, plus
>>
>> Unfortunately, currently vmlinux btf does not have non-percpu global
>> variables, so net_namespace_list is not available to bpf programs.
>> But I think we could do the following with a little bit user space
>> initial involvement as a workaround.
> 
> What would you think of another kfunc, bpf_get_global_var() to fetch
> the global reference and cast it with a type? I think even if you
> had it in BTF you would still need some sort of helper otherwise
> how would you know what scope of the var should be and get it
> correct in type checker as a TRUSTED arg? I think for my use case
> UNTRUSTED is find, seeing we do it with probe_reads already, but
> getting a TRUSTED arg seems nicer given it can be known correct
> from kernel side.
> 
> I was thinking something like,
> 
>    struct net *head = bpf_get_global_var(net_namespace_list,
> 				bpf_core_type_id_kernel(struct *net));

We cannot do this as ptr_trusted, since it's an unknown cast.
The verifier cannot trust bpf prog to do the right thing.
But we can enable this buy adding export_symbol_gpl global vars to BTF.
Then they will be trusted and their types correct.
Pretty much like per-cpu variables.

