Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E587D5224DD
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiEJTgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiEJTgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 15:36:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569D47ADF
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 12:36:13 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLIU7027924;
        Tue, 10 May 2022 12:35:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KuUaeHXENoVvyYjUxUBkgfKL1Serl06BiwiW8In/LDY=;
 b=dSC+1EKUX08L5cpsmHmYmwRWFyDQyK93cZSRWUywEqjNBY+5pIL83lgbEeOOkEjUH/rq
 8y+rjMRC+UvTo2gpC7vB7JydAAeSqkjkcNrq6tcXOrw7kEVu06U5AZ71WI4bwaN99KMk
 GPBimzRrU9TNmqLOOlYLIbH/PWkqNz1fW9c= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fymp4ce0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 12:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIfLGLOf5IyyFTwujF5yY+LsN2JMgQBw4MEO4IE6upOhaArSMc+Bi/6JQCoq955QV1kfD+l3lYYrQX8eeZsm6+65PmwgGxlivO5SeURa2r9F6Bp//m2zrLxraz9ph+MR8vPk8OxBD0ZcbKGZh5oysLZAsrrPO/sDw6SmMVgJWT2yvrtG2vf1Ziz2PlV037vM851vt6GRZQGdHbdJf3Ftey+a3yXQCiCosgiJVZk/FxKeXuldOJQT4MclYpTDgFY0Gu/Wn5pSblE9Mh6nbotie2UpllKnVO7DTaVoUzGBdFWn+umdCl3PCU9kfNBm8/2iILMsldyPzePs9AYVkSHhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuUaeHXENoVvyYjUxUBkgfKL1Serl06BiwiW8In/LDY=;
 b=e5hzdNUy3n1Rik93UwnYok8cY9FtszH4k8t1iQ4+w+WP516AuE7GjR+AjlYTd9PnpdFMW7mJT9WEWG5yrCVQNwreo9p/yObJjS1mo17XoFwiJFnbJ2L3rW7o5lg7px8KqWyrSibe0buBqkPW+At0VoIt1hXPvK6RwZGu09e/2kkCWrKRNoDGjakJfupU+MvLrZBLF7malPqWxC3i7tGf9JkMVKT+lfog/vVQ1pGkJ8frxpgRj4LoosKvg4wS1vfvI/7N3NeipztsGhzx5cq8oyVUa0JCNO2sMvg++dngazce3GbRzVt38X5ChUOn4H3mQS2SQHsURM2qGpR7lDWWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1519.namprd15.prod.outlook.com (2603:10b6:300:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 19:35:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 19:35:56 +0000
Message-ID: <5178855e-068b-0724-aef4-b54cecc1de04@fb.com>
Date:   Tue, 10 May 2022 12:35:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 02/12] libbpf: Permit 64bit relocation value
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190012.2577087-1-yhs@fb.com>
 <acabc26f-2d6c-ee74-f99f-58ba3f796401@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <acabc26f-2d6c-ee74-f99f-58ba3f796401@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c68018e-85f4-4218-fe67-08da32bc4dda
X-MS-TrafficTypeDiagnostic: MWHPR15MB1519:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1519D6FD08568F680FAFAA27D3C99@MWHPR15MB1519.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkmzYBsNX6RAtYpBe+SoA+4IDz6yLUjT96VhLQ8IAi+w4KmMk2nzKmO7+bB906adRc2+IrIpo8pkDiV3/6Zcymeb6t3G3KYjklQuNqqYpF2LFPSX8UbEcVWu/suGb40a52aNx5YImg0tq/Wc83DuGjRPumdS/WnaK6ksWlpICK4nsQBTIo/yI2knwPQ6IHvR2K7Ea9htyk4/Yyp4kXo5V3ij0cR+r2O1gGd7VnfreDxgR7RFhIUmkpCN1xCJdl3bpQyucWFoHSKEL4gZOTqLhFfDT6sc+0mnb5tbQlwRo0vkUOOxsJH4yL8c+KVpZg5ilAoP9Sr9EQ6pE94zUlFUrwCw0gmQzjNPLmqpDO3eTDWD3U9EpGzrgEGduiHCpw+KJuJBfzvSyV1klk11YjGL4SrL9ERyDXfDGJO+tnhtfPm4yfekxdffnJgXYYb3oBl4f5GnCxLm9G/lfDKLQG+icQjvMC4w8Nnc5UkXmaFEmgBjExlif3IX/Q4lqr5rUAWM2ey8dcAJLijkK2w5cXtMvPX9Yz3M/mpP6Qt0pv1WCd3Mu26nnBQMZF+Fwkm3uQ7kGqlZx3LaFzkNVmizwXV+k39jTZcVmr1iD0RiPTZ6LybNI5+82bAFDQZIrnNYfabpG+nNMgu5d9wE5PKdT8exCkVJmkkQHj7uORGsPdcSQEqlMGItCoAV2q3CQCjKich+HolsGy/m1maYw6rWZGfQw/OiuHBr/Y4SKm3aLQr8xcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(508600001)(6486002)(38100700002)(316002)(8936002)(54906003)(4326008)(66946007)(86362001)(8676002)(66476007)(2906002)(31686004)(6512007)(83380400001)(53546011)(6506007)(52116002)(2616005)(186003)(5660300002)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckduMFYxQjlsbFU0LytDbkx5WHpPam5BWUtHM3U5Qmk3N1NqcThCL0p3VWNz?=
 =?utf-8?B?KzVseUZoc05raUd5dmFIbzAzcWhtODVST2FPbXFGRDFNdG9KQkw2UFQrbm1O?=
 =?utf-8?B?UmRZU3BtTkw5QXRoZGtSWGI5alFld0dpR3JHZVRwMStqQk1PTWtCMWQzaXFx?=
 =?utf-8?B?WVM4VGc1UmhrZ3JKRVc1Y0hKenhUOUNXbDFNanQ5ZEJkL2FtTlRoSUM4eUds?=
 =?utf-8?B?Ykk4MWxINXVqRWdLaWFXRGFrcTlVY0hSdU9sU0I0eGVPbE1WUXlkNTZobVN3?=
 =?utf-8?B?S2R6RWZLWmxZZEJuNDdRK1NlN2J2K0hGMnVwa296dXVVemFMak0wT2d2ZXZy?=
 =?utf-8?B?emxObEVlSmEwcUhUZkQ0dWxNOXBwVHFKdndKZCtXUXNUdW1TNFM4QkFPSFRR?=
 =?utf-8?B?NHFoL1JpZVdEbVcxY0ZkOVF0TlBPb21lSnhBeXVHYlFLSnczNmw5ZXJGNFcy?=
 =?utf-8?B?TkpoZ0hvRVMwcEZwelIyS1JPRFREZzg5WkdXMWpRZmUrL3VneWR3Y1RrNWhp?=
 =?utf-8?B?Mi8ycnR6ZUd3NHhOVkJBUU1QQlJvUFhGSC9DZ28yYkNvZWcvc3BFU2pRRFdT?=
 =?utf-8?B?QnRuSHYrYm1wd2RSQUxmWW95akhpNDFtL0daVnJ2a3ZWbHBZR29IOW1QbnRr?=
 =?utf-8?B?V1BVaHFDN2dRT3FOdElVTytOWk1mZWJYbWw2TGF1QzJNU21LVXordHo3U3Zr?=
 =?utf-8?B?R2FKNGpCVDZxL0F0M2tJUTh5bTNuWitibXdRSWhvTHlLWkp5WGIza21KSzlL?=
 =?utf-8?B?aitiRkplSzdOWHZoN3RFdmtmNkZXNkZtQkh5aDBOUGNsbjh2NmZLMUZxQkRP?=
 =?utf-8?B?dmtKZ2hpdVZqRVhnR2Y4TGRWSFU1ZGpxVDhPYVhCbjhGMHdrNGdycFpiL254?=
 =?utf-8?B?dmgyZW9odU1Mc0pWaWdUdEJYalhxSkxtaFN2Wmd4WW1MemhPNXgrZFpjZ0N2?=
 =?utf-8?B?bGZ0TlJyL0ptdjBZVVhwb3V6eVJFa1BmWmxPVUs3WXFISER0bHdCQW5zOEc2?=
 =?utf-8?B?Q2Z0ZVRqaytkWDRVMkw4USt2RDRsd1dFbFo1ZSttalE1MWJsYnE3a0o4YkpR?=
 =?utf-8?B?a2hvRlB5YVZZOWJkdXV0STdVcjJHZXpBK1p3a21JWDdQT2xpKzZKelM4K3Nn?=
 =?utf-8?B?WWZRV3pOU2VMMGxSQVJvd1U5Y2U5S2VqNjVVd2ExK1NGWGZoUDcvY0tUbFcx?=
 =?utf-8?B?dWdvTWJxTXVTM2FzcjZGaW83cCs3cUwwY1lFTU93UkdXR2hFa21Gclorc3Zz?=
 =?utf-8?B?UVR5WlVqUEFsWFFoSUgxQngzenZEL0RxaWVJWVpGYTRmTEZlcDgrbUNEYko0?=
 =?utf-8?B?SXYrRlZPRXFWNDUyOEZUelRNZ09TQnI0QXppcC9iM1c3bDdWeVdzZGk5NjIz?=
 =?utf-8?B?OUJkSjJOLzNtZVBaR3c5MmZyWENjYmQrV00yMXkya3NqNjdmYmhnbytpc2Jv?=
 =?utf-8?B?OWVZQnVoRTRDenJ5ZDE3QmdtQ3BZUmgvWE1kTVE4K0loMkY5TldGNXdVeHZa?=
 =?utf-8?B?eW9sWWoyOWtBUjBRVDBUeEcwaWw5NWhSU0huMlZPYXJOYXFYT1VYWUtMYXNQ?=
 =?utf-8?B?WnF2dEtmOE10VXJXMHROZ1FWU0U3cjhvVE5kYWxaRDdGTzVHNGMvaml0R0Mw?=
 =?utf-8?B?RDkwNFVkeHM5U0Y1dU4yWDgxaXRUdE1jS0JqVVhTS2hrR01taHZaN0o2WUVK?=
 =?utf-8?B?UWQyNlpiQjJqb2RpbkQ4VTU3ZGN6SFN6UnIzNTUzbDZYRWFaQlVCQ1BjT0Vn?=
 =?utf-8?B?SGFmNTVMV3Z3ZmxvYXpIVng3ZUdPc0IwWEZwNlV3cDhtbEdqQWhRc3RiQ3NE?=
 =?utf-8?B?MC9WY1A4ZFJCV3dwZjZIV0pVcGhTOVhzdGhqaFN6SVNxbGNHMThNay9FcWpD?=
 =?utf-8?B?NnBBSEFnSkZQNHRtdjJQN0RqNHczSEF1ZjdUQk14bVVjNEtXSHlqVEtOQTVT?=
 =?utf-8?B?Q1Z2SGdYZVQwc3V4SmlwazV0akk1aHhyaXlTcWFhckhaRkh5MmdsN0pGY1U0?=
 =?utf-8?B?a1ZJK2h6NDNmUk9zL0dnbzcrbEV1Q0hZYzJseGZyQWRvQjJzcUJKaEZoSDg4?=
 =?utf-8?B?N1FkTzd2TDIvNWZWZDJLSjVxOXJhNE9adGIvRzFhTG10Q2tFUWlaTHBBdHZL?=
 =?utf-8?B?UXhaa1BYYXdhNFM3eDBsV3JHc1h6OUxzNVM1djR2bStzVkJXcWhITXdyMmFF?=
 =?utf-8?B?c1hDTEl5TkdSQTZVVG0zNVVjYW9WOG9ScW51L3Q2bEFkaGxQVGM5aURrYXhu?=
 =?utf-8?B?eTJoOTYzMGNLVVJiNFp0eld1SFp0d3RVWWg4MHlTZ1NPWmdHaDgzTXk4OXZm?=
 =?utf-8?B?UW9ob1Evdk1Wbi85ekVYVkJiM0x5NGNuUGtwdm95NWo1WTd6Y29BRFB1Y21N?=
 =?utf-8?Q?jfhmlr+ZoFFf/fn8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c68018e-85f4-4218-fe67-08da32bc4dda
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 19:35:56.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c5Ibed1+ymXpTD3v+HdymGv5bIGQAd0Rr43MaBRMm8mC5xFAvdcDuMtNllsC+ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1519
X-Proofpoint-GUID: JMKmWeNDu-D5pFjgWPZ1ZSKEpa4Dljpg
X-Proofpoint-ORIG-GUID: JMKmWeNDu-D5pFjgWPZ1ZSKEpa4Dljpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_06,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/8/22 6:06 PM, Dave Marchevsky wrote:
> On 5/1/22 3:00 PM, Yonghong Song wrote:
>> Currently, the libbpf limits the relocation value to be 32bit
>> since all current relocations have such a limit. But with
>> BTF_KIND_ENUM64 support, the enum value could be 64bit.
>> So let us permit 64bit relocation value in libbpf.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/relo_core.c | 24 ++++++++++++------------
>>   tools/lib/bpf/relo_core.h |  4 ++--
>>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
>> index ba4453dfd1ed..2ed94daabbe5 100644
>> --- a/tools/lib/bpf/relo_core.c
>> +++ b/tools/lib/bpf/relo_core.c
> 
> [...]
> 
> 
>> @@ -1035,7 +1035,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>   
>>   		insn[0].imm = new_val;
>>   		insn[1].imm = 0; /* currently only 32-bit values are supported */
>> -		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %u\n",
>> +		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>>   			 prog_name, relo_idx, insn_idx,
>>   			 (unsigned long long)imm, new_val);
>>   		break;
> 
> Since new_val is 64bit now, should the insn[1].imm be set here, and the comment
> about 32-bit be removed?

The comment and setting of insn[1].imm are changed in patch #4. But yes, 
I can move the change here as well.
