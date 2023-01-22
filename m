Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE4677140
	for <lists+bpf@lfdr.de>; Sun, 22 Jan 2023 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAVRyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Jan 2023 12:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAVRyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Jan 2023 12:54:07 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33E14EAB
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 09:54:05 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MFqGIS015950;
        Sun, 22 Jan 2023 09:53:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LxhP7cXZtibHdpFgwIGHKO3ECIeyVrfb0sUaoQOeans=;
 b=Dc1fek1WWGON7VtjDzGrAxEthVK3LOZSI+bSkl9Tmvt/OnscAN67U/qOWuKASPF6xFSt
 z6ShQl+4lxU8Hqc9F0NiMk+pmKbJuelwZul9Y4O3k3Qf6gMgAKDDIcVmI5+4k98tVCoZ
 pphRmWsZWwNh+3MZUaFoPE42guloWAuvzJnxYXtQNPDa0pCxbtdq+UuaM8btv/jwUhaz
 tli2VCjuYqFPauxW+OwXjOMg7wSWq96uSk3qBWCyQC3MwJrxkvtO4wQd4nYmrh00ktgn
 A7K0EO6BU5t+LBZfm/OthIys0imoSCVZhhV4ZZy4KBnUEg1nYSZ68h/l3R7VQ3phmri6 pw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n8ef3wup7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 09:53:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4U9nChTmfXyX6a5M4FZ7h0U+LaeFnni2yK/hVjq25VDMKqyiMeNPm+16fekz1rnK793jKVFjlK5wSv1h+f1dJ3EwEoZsO4z8y73StDMCoWdm55G5NnM/wLg+8wIOPdHdRaP3C8LTnkogaIY5nr0MqMHoHeMHLVOObMgrxbY1JR40i7/bEMgSO1lK/Jgqymx4HCQdVpy11PLqWHwksLPZm/lEuBBTe6gH4E5k0hM1nLeuHU1SF6gdzc7BFGDGbRmONrvs+zOTHme0KybzjI4E0VEhielGtbdI1lg6N+NFRR8VVUUhNRXnrJgbiL99l3Hi1YO2u/9NfCKjvGBQ6bcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxhP7cXZtibHdpFgwIGHKO3ECIeyVrfb0sUaoQOeans=;
 b=PHVk3sVL2+0KEectiwe6qa9Kay4006QdA4ugSel+VvjUTnLKFPq50RtJzNuBThpKGB15M9+YQNLvIdAB0LzAmNaOzCnm0r2OaEpE9/QsUS9qIkqUYC7xHj0ssF/9bShrkbeNEzYv8VpmeUMYZlKdUCN04BDCQRbigCq+kN1UndVIEsNkL+eoWxeEyiQgHm2FKXycvFlOu6fmEMvkBKPo2U9cfeIsaPmnzq9cW0hGJYoOt16q+j2qb2GVcxKxPk1tThlJ7EIJ/Y08rvYLVGHjXVYVTBYamE55Oxa/QZ+tNZGiemhO/a2sKtWtvA3GZin7Y0RePzXiT9ns0TRgz+y7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4161.namprd15.prod.outlook.com (2603:10b6:5:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Sun, 22 Jan
 2023 17:53:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.033; Sun, 22 Jan 2023
 17:53:54 +0000
Message-ID: <f3963ae2-2a9c-b8b4-2b19-ebbcc7863b8d@meta.com>
Date:   Sun, 22 Jan 2023 09:53:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <877cy0j0kt.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: f038359e-4c6f-4978-7917-08dafca1a06f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flkTKusQiVMAKxUgH0vqTy7MtTtNFerQggWHbOUycF/hrmfonsP7PvCpb5oRKiCtpEqmSXs1HTC0+gmGOVJG023F5eCjM1V1HGkYSX7uEGrXQmFyP+lQ0TKo28n77/yHGabKqbAjhG46DdnOxwP8u+SZA6zahqZgniXBs7ThVsXOKTnr+Az7djbnPYafAXMMIdVUB2Le65E2cSVJRqdemfCVwclYv7mU2q8vK+JHycmpQop50jlorONe6wsKvigD3b+FzQVP5p00IEB8b+djVUiR/IquiTlCgVdkcTsFUVCIK673VX+T/c1WAFc1Dgb/Ici6VDq+vCqp68Z9ixtD3vDKdOYIV823EReZSxFl7qXo76Kc4ZL7W+S3me+O4saKPkuFg1dKQski0q1JFbNABW3ifgN+PJVcYOnB1UnExYMe9x/qFBm50W5OixPpKjcA2/zai8LYBu06LubHlF84Hy49/9XaXH5UQ1iKZppJ/bRf5jeCemUWSNnhJAmpcFpxicfdDkXWZ+AJYLNVwHUDMEvfT61MliQtQlICbXzLX7lTBnShSKJxhw4WG26hxlEjHctsqGq5ILX2f8ElY/NN6z+dvfoeYD9NrN6yFEjiyghoeGl4BJZrPo+VQBgCUpmF9v2kuMohOpBh1kbnb4Qq5fPAOHPr2lZytZ1vnmsmMYLV7+aSun8ZPXv47XG39GuhCMnthiRmIC/uZEhMbWVdFbw6mOYad2sGJDH0juRoBaj35UjsYDD6wVf1jcrxRe3yYs4tDCB3qGP3ey/J20jGoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(38100700002)(83380400001)(86362001)(31696002)(2906002)(41300700001)(4326008)(5660300002)(8936002)(8676002)(53546011)(6506007)(186003)(6512007)(6666004)(2616005)(316002)(54906003)(66946007)(66556008)(66476007)(966005)(6486002)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpBWHFSMWRWY2Q2TGlUdWQ2aEl6bW4zNExITFMwODNMbEdJWm1XNUk4b0Nv?=
 =?utf-8?B?Rmk5MGxWYUI1T3NIMlRiUFdlWFE0M3VNZG44SjRaLys5VDNFQjRsSEFFRFUw?=
 =?utf-8?B?eG9tcCtXcnBucVk2NVVxaFNXT1FTRG5pVWlTYloybTQ3MWlrYUYvRHMxMkdJ?=
 =?utf-8?B?NzBSNGdCcE8xcXZESDJXeVVkS21ZSzJGTENRNGY1Y0MzM09lN0kwM3k0NjRD?=
 =?utf-8?B?S0ZkWVBUeStZSTdCQXR2NHJYekZiaFdFc3dRNExtQU9LUDR3MjRiL0p6YzZ0?=
 =?utf-8?B?ZUN2c21KSWh0RGNIVkxGd3lzRW9PeUFsbnNPWms1TkIrYm5STU1lVjhxRVVK?=
 =?utf-8?B?ajBBbXA5bW40cFh4WVJpM2tOWjMxQmx3NWxLeHQySnVxZFBWNjE2MDBsOTNu?=
 =?utf-8?B?VHI1M3JJakJZR1hVS0REbVVXUzBUcUxkeUdhRmxzUWpycXdYWjM5OUJOQlFm?=
 =?utf-8?B?U1dRNE1hU3plK2VlOERONGR4UkdwYnZWZGp3Z3RGd092WEh2NE13UTd5RlFE?=
 =?utf-8?B?MUlOSmROWXhKMHRGV0IxcjlpR1c5T21qMENBVGwxNGNrcGFSZ3ZhaUhuaTQz?=
 =?utf-8?B?MGRwNkIvRTZMYzJxV3JJK2tmOVRIYThVYmN1S1ZVZDVYbklYU09tUC95dE41?=
 =?utf-8?B?M1Z2NkFXZjdHVy8yc3A2ZSs5QnBvekFMb0VZZEtzbitoMXBXdXRwekNGTzlS?=
 =?utf-8?B?eWVuK2Q5dWx4Z054YWw4cHc5VWpOV1JYTGxTVHdHMmxMelhnT0lwOUtTYkll?=
 =?utf-8?B?d0ZmRW5YMUhZa3NIUzZOSEh2bnM0LytSbHM3dEJyNkFWell5ZUs4V3ZHZDhI?=
 =?utf-8?B?ZkgxN0lxbkpnTlBjc3JtR2pvK3NmMi8reWtBOHNIY1RXN0tFYkVDWW9kUUFY?=
 =?utf-8?B?VFppV3I4cFpNbmlPcG5EYnZPbmVUS2hYckljNmwrZXBhY1kvdmo2ZUtoQW8w?=
 =?utf-8?B?RDBIeXRFdDBhQWxBZDFVZUQwYlYxTVh3OE9vbXp3bTVxYzNJK0JoSjVUYWpK?=
 =?utf-8?B?Nmh4S2ZzME1ack5ZMjdnUFVISXVTNllHTlVuc1pJZ3VQRFZjTVMyckpmSk1v?=
 =?utf-8?B?emFGZk5xbjVYVDZET2NyMFhmODYwaWJLZjEwc2hzd1l2a2JDOE9HYVc2SEN3?=
 =?utf-8?B?R2UwRDdsdXBpQUoyWVRVVExTYS9UMDAzd2xlVi9pSzFhVVF5SEtHb3pDVEo1?=
 =?utf-8?B?d3JGb0UxVGJMT1pDVnRLRVlKUStiV3E2Yitoamp3WERMTSt1dVhKVkNnRUxt?=
 =?utf-8?B?SWREdXJzL0cyeG5hZS9vUXR3azFJd0tJRklTUTdBZnA5dUJob28yQ3J5SDRS?=
 =?utf-8?B?aDNDU2RDQ1EvbVQ4dUh0a0ptQitHUHk1MGZwYTVKelNsd08wS2RSbjVsVjdr?=
 =?utf-8?B?Zk1qU2Y1WUZRbkdURU92d1FWSHQvVUMrYUNIY3JzRTJIUlA2YnVoOFFqN2Zs?=
 =?utf-8?B?QTBTZ2dXNExFelJsbnpsZHloL3pQdDlxSGJIOWRCTTgrRExTQTdHSUpqSEMr?=
 =?utf-8?B?WDR3R1dTSHphZGdzdk9aY2ZzTHVvV2NiOE5rZmE1MDNYNFg0NU5HYm50cmJR?=
 =?utf-8?B?VkRqN2pTUUNic0J0S3gyRkNvaFVkUDFITVkyUzVNOVFmTWJpOEhRUTlrVjNp?=
 =?utf-8?B?Y0k1SmM2cG1nbmovdzNZZGsxcWp4U056eWVVYjV3QlM4dkJJQktTc1lnZG90?=
 =?utf-8?B?dG9WTGdOcGJmT2RQOUozOUVaVHkzeXY0RnFYRStrSFVMdFVYbE40OUdIZnBS?=
 =?utf-8?B?Uk5FNWtVYVRvcStwL0J4S2lBYU1WZkptY1dUUjVUa3ZxdCticm1ha205VEt1?=
 =?utf-8?B?Wk8wdmc1dTFiRVFtSVFBc2FtU3JUcFl3elNFTEc0TkNDUW1MdDBSNEZHbjV4?=
 =?utf-8?B?T1dCdDZDZitpUG1uWTk5K3ZLTk0vdFBvRC9tUHJ5U3pXbUdiVk9GcExpTVgy?=
 =?utf-8?B?MEUxRTgwMlBScHBhM0Q2czFlUGZXbTVoUE5xTVR1aDVRdkJyaXFpR1pOTFBX?=
 =?utf-8?B?TmtBK01TMGw4ME9MOERtSStkMFBrMXdXVDVPaTdleVNON01HNFliZEhlTTF3?=
 =?utf-8?B?c25RNGljYjJNZUNpMjkyZHpGN3hHVGErSVI2S1hiSmxJNVhvbXc3SjBHMU15?=
 =?utf-8?B?TmIwd0cyZXRCQzV4b0E5b1RFbTdWakEvM2lWYkFNZVNtdmNTZU9sc1U2V204?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f038359e-4c6f-4978-7917-08dafca1a06f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:53:53.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBqonURbnITxfbrZtfeSgQ0i9YIgnbGYBwQRw+SKrreAw1ap1Nvd7Zrw4vtqFYFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4161
X-Proofpoint-ORIG-GUID: oJPTRcekbEhpMKpswPuXA9OBn9OaGTca
X-Proofpoint-GUID: oJPTRcekbEhpMKpswPuXA9OBn9OaGTca
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_15,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/5/23 10:30 AM, Jose E. Marchesi wrote:
> 
> We agreed in the meeting to implement Solution 2 below in both GCC and
> clang.
> 
> The DW_TAG_LLVM_annotation DIE number will be changed in order to make
> it possible for pahole to handle the current tags.  The number of the
> new tag will be shared by both GCC and clang.

w.r.t c2x attribute syntax discussion in 01/19 office hour discussion.

I have checked clang c2x syntax w.r.t.
btf_type_tag and btf_decl_tag. They are both supported
with clang 15 and 16.

See:
https://clang.llvm.org/docs/AttributeReference.html

The c2x btf_decl_tag attr syntax is [[clang::btf_decl_tag("")]].
The c2x btf_type_tag attr syntax is [[clang::btf_type_tag("")]].

$ cat t.c
int [[clang::btf_type_tag("aa")]] * [[clang::btf_type_tag("bb")]] *f;
[[clang::btf_decl_tag("cc")]] int foo() { return 5; }
int bar() { return foo(); }
$ clang -std=c2x -g -O2 -c t.c
$ llvm-dwarfdump t.o | grep btf | grep tag
                   DW_AT_name    ("btf_type_tag")
                   DW_AT_name    ("btf_type_tag")
                   DW_AT_name    ("btf_decl_tag")

I double checked and the c2x syntax above generates the *same*
type IR and dwarf compared to __attribute__ style attributes.

[...]
