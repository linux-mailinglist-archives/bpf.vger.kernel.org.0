Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA1320FD7
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 04:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBVDqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 22:46:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhBVDqJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 22:46:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M3eFJX019011;
        Sun, 21 Feb 2021 19:44:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Tn1wAHCn8L6p9fyMQcx+hsNYqPLBexbgjMd3FrXt0mk=;
 b=AIwV+7dpulIYQCD/5o8Y8QCUD4ZCv5VHhpoRRxImqffKcoCqYEipq5DZuVJektMwv1ZW
 6UDs93jAzEwNGjHnHY+Jh3kUthxHAf8eNYMec1XCsy6CxsjWv6Cv7QLpZB3PMSXP3Efj
 u+BOHJGQ3+F4lMfzRHoutn+2+58PssS8MqA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36uk4w2w7w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Feb 2021 19:44:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Feb 2021 19:44:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoPgXd3obkmN2RUliluLxy+eA4fB9IJBq1Jp8dRwqSUeorlrRbZ0OK6ceFAq6cUjXcv3PzVAsjMV6M84fbng+i+w8kSw284aAlIuDORI2wio7yEipEFBxxANPUtTJsMiDvtVy9XeqOswvZWdoIJdA25u1/q/skIKPHPumfr2BJCHayld+EBsbJ090bpIoJVbkhPxApsmnNvwxNhZ4DXf6Gv4gITGDyef1RtTmNruvy45YzD3kg3gUybSzS3bpm2272RTdjD2jINM8yALeW7KJqIKXwhs2ans50PsuwgSpLPQtBda30YPbyk8OFi5eDEHNlETIuJWmdy5m1ntaVRVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn1wAHCn8L6p9fyMQcx+hsNYqPLBexbgjMd3FrXt0mk=;
 b=VmGqfiNzHEcOFXzCvGuaRTYuxZ3TXJVuDWevnjqKFVNi70r+KlfQYNFBaOrJ9AMUOMdSwoa5jpQ+wPmTnbC3IsnJNDoIPR9pmtHkd06buroMrrdmX6nsP38QPJ3vI3KCPQ4FfjD25uKZHLFkEUGvBahdcJ3h79lwxOrQ9iO9xZwHJScPyRtH/BxBREzDnkiUpI88uLwApWOZQjaO1HHSoQcwc/mxLL+atcizUm9gG5nyFJnN7rzZ1dIEaCBEoD4+EUvspVRw8OY++fGXRa8phyd5Wx4XuQfmUJkibexurTU93xUvbzbhgz987TrGJvT6GyX1UugHTCMnaM6Jctaa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB4070.namprd15.prod.outlook.com (2603:10b6:5:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 03:44:54 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3%3]) with mapi id 15.20.3846.042; Mon, 22 Feb 2021
 03:44:54 +0000
Subject: Re: [PATCH v3 bpf-next 3/6] tools/bpftool: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
 <20210220034959.27006-4-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dacb8232-4dbe-37bc-80b8-7a069019f587@fb.com>
Date:   Sun, 21 Feb 2021 19:44:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220034959.27006-4-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4afa]
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:4afa) by MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Mon, 22 Feb 2021 03:44:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 546b05eb-06b0-459e-d4e5-08d8d6e43730
X-MS-TrafficTypeDiagnostic: DM6PR15MB4070:
X-Microsoft-Antispam-PRVS: <DM6PR15MB4070EF2F46315DB0718ABF90D3819@DM6PR15MB4070.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u19zE0sBOuVe231xLTrkvr4eNG4o8NA/T9KwBpF7G21ny7IVtdzoz29/LPWMUJHtuvbr91TwUjkJCfAs3xv1vN53TfOjulURUa2ngDhSpW6qGKbhljRWDagYBgkLekuEcFum7XtkPfjXRBV4eUK3KsOfBM6xHtFW77gbsUeP2T3ngc4+Fo4bdNs/CQSApwf+yEhDFEw44y87IzlBOaK8Qu7YCZxk99odsAD6S4NcchVu60utoFis4ylBXQ3l7ryU8B0IGEQPCSMk7vB5LKsZC7as2idt7TgpykcXPzBQJfPazhMrfsB3CUynhST9RixoRffZLIT4AhDbivSSi+LBye2F8Ub517PHxOpudjNVLHs2H9kG/ArAQx1gwZz630xy3QVSXalAxAnlf7NuHaueRD/7d30i6LSRrOjqEiK6JRsmtvkSUnSfPkmV1rhBySQweAzXdhL/SOMCchOipVTfH7XFhDSZ++6r8GTSL4qZfDP4jgzIuERxJyiWGBIcvNIPH4WAMxNuo/4M9L9+f7b5kR5hBM1Vc0+Vvh49jISSZl+vw9JKqGUkqiMapaesfkLY+tc3uPUdrucM93suEu2utA2Alpjdh5H6tmcoaG4KZxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(86362001)(6486002)(5660300002)(110136005)(186003)(4326008)(316002)(2906002)(478600001)(54906003)(31686004)(66946007)(53546011)(2616005)(8676002)(66476007)(16526019)(66556008)(8936002)(31696002)(36756003)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEF0WXVKVWVNNmkxZXNWVlBmZXBUZndLY1F2MnUyT0RZNVJxTlBEZFFSdmRO?=
 =?utf-8?B?WjhMaVBRaHcwRzBpNGxidS9IUE84ZjY3aTIySnVzS2lGSnh5ZlpPUzhaVXdx?=
 =?utf-8?B?cEJzdVlwY1B0SXNVWjBxaGVxTmNHNkFWTmdVcmZKSzMvVGxJa3R0elpsL2hP?=
 =?utf-8?B?S0xNVzRrUzRXMmRCV1NCQzFEdXpyRzlvckd1dGw2YkFCN3YyNVl3OUgyNkV0?=
 =?utf-8?B?NG5Ub0tscmdVUUR4MmVUaTI5QnZWcW9HYXFpYWlNTFFvRldCMkcrSnFZRVZs?=
 =?utf-8?B?VlY3dDIxZ1c3REtEOVNTejhpRUw5VGpjWWQ2c2YwSVpFdHdJT3RjSWxXOFho?=
 =?utf-8?B?dG83V3FuY1hvYlNvb09JMi80S2FSYzRnSXFwVGRNNlBPZlZzRkcvekRKaTNi?=
 =?utf-8?B?TEUwQnZqOHJwSTlJRXNsbXZtcUYzMEdqSS90aHFjaWxMbDJaNkJ3alhSMGNo?=
 =?utf-8?B?WmNscHlXZWJqTFhPYUEvN0xHWFRWajNvMFVNM0F0VWFuY3B0UUpqejUveFFv?=
 =?utf-8?B?YUorajc2aXVIaUduN3FaQWUwWGZwUGVlZUJVVEM5emZ0MGtYRGNodFQyZFlK?=
 =?utf-8?B?cm5LREZRdEdGL0lZeFVOaE5qQ0FmOTYrNVV4bmRNaUlod0dwcDJXdmg4WS85?=
 =?utf-8?B?OE5JRjlJZTlWSHJ5NCtOWUthUHk0SiswTDRKYjZGOXZhMk1zL3h6KzBZOU5J?=
 =?utf-8?B?d1hvd0c0R1h2NldWRFd0aUZ4Rk1aZy9DL29MM3J0dGd4NEZSdm9DWDU2NkFh?=
 =?utf-8?B?ZUxweDNlU0U5R2hjOVdYZjYvcU1aR3k2cEVxUUNaZHhZNEFVWVd0YU5zdHRo?=
 =?utf-8?B?V0lYSXN0a2hhZDcxNVpheTk2ODhqYU9ZcnZvRlMzNnlVdDVNWElaSmtCcndp?=
 =?utf-8?B?aUdRTWJKeHpVREM2SXVDL3Rxc0pybE95ekZocHYyTy9ZbVprc25ua3NLTFh2?=
 =?utf-8?B?RHBJSUUrUUs3U29LcUlFdGdYTlRkNXpoT2ZRSFBSejlka0Fycisra2ljUWJ0?=
 =?utf-8?B?d2FlS1FqSGVvc3oydmpmcTJUdG1tdlBjdVFweWkycjVtRHFrcUh4aVhBQ2FI?=
 =?utf-8?B?eWxyUytjcVI4bVIzSVlhMnN2SndiM1RacVFMbHJlcUU3clJ5Wjl5VmRhQW0x?=
 =?utf-8?B?SmFzTWN6Qk1rZXhhdlBLRGw5NHBoTmd6cFZESjFxVjljTjNNZW85L1E5NG9v?=
 =?utf-8?B?WXhZMTlNcHZHZUlINUNZK2lWaERabks1Q2NGclJoK0dtaDRSZVA5eTFUWjV1?=
 =?utf-8?B?TzgvUWFlVFdLQ3pYTkxhalhZeE0xSFI0emZibmhWOEJzK2hwMis1di91QVNt?=
 =?utf-8?B?WlFNSXQ3UzR4YkdTYko2TzNZWldYdWpObkdmYVJuV2RNa0xwN3VQR1NFeSts?=
 =?utf-8?B?NzRDSDdja2N1T294L1UwcTE2cDlKc3lBbWVrb0NOOWtrTzlxanpoWGs1VUtk?=
 =?utf-8?B?czN0bzhkNE5zdERFNENqMklZN3BwZW5sczFLL3BkRWJCMFNiTnAySUJtVkhH?=
 =?utf-8?B?d1BRNDNRa1plbStGa1FBSm9IaVlxVTYwSUIvM3NKNnV2VUpkWTBCSU9hRVRq?=
 =?utf-8?B?WSt3VDlvbGtZd2FkaXc2cm1pZGZPcGltaHQxK0lqamZhb1hDKzJzcnRkOU9m?=
 =?utf-8?B?R0s5ajJJNTFEbXc0a2UrYXQ3RHpKYnVabExQOFpHdHh0ZjYzNThVaXI0OVlM?=
 =?utf-8?B?Zmd1UGZBaXVtODVVUm90SnVCa3daWnF5WmUvQU1peW9CUUpaaTlGbUpPc3Jv?=
 =?utf-8?B?VlpleGI2S0VmVFVrcVJhVU9ZQ3ZKSFZYZGc1bE9aNXl6d3JmWE10TFBUSG91?=
 =?utf-8?Q?yoCRZnyRSZqGgw95zGbWpJ2OXS22vmFW1Hyec=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b05eb-06b0-459e-d4e5-08d8d6e43730
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:44:54.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jdVF20zh07QDwr9pnpBlhWbk/WVkIBeM5Kcjtx6qWMv32P0bcb6I4UAvUJOwkE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4070
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 7:49 PM, Ilya Leoshkevich wrote:
> Only dumping support needs to be adjusted, the code structure follows
> that of BTF_KIND_INT.

Maybe give an example to show what exactly the output looks like?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com> > ---
>   tools/bpf/bpftool/btf.c        | 8 ++++++++
>   tools/bpf/bpftool/btf_dumper.c | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index fe9e7b3a4b50..985610c3f193 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -36,6 +36,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>   	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
>   	[BTF_KIND_VAR]		= "VAR",
>   	[BTF_KIND_DATASEC]	= "DATASEC",
> +	[BTF_KIND_FLOAT]	= "FLOAT",
>   };
>   
>   struct btf_attach_table {
> @@ -327,6 +328,13 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>   			jsonw_end_array(w);
>   		break;
>   	}
> +	case BTF_KIND_FLOAT: {
> +		if (json_output)
> +			jsonw_uint_field(w, "size", t->size);
> +		else
> +			printf(" size=%u", t->size);
> +		break;
> +	}
>   	default:
>   		break;
>   	}
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 0e9310727281..7ca54d046362 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -596,6 +596,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
>   	switch (BTF_INFO_KIND(t->info)) {
>   	case BTF_KIND_INT:
>   	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_FLOAT:
>   		BTF_PRINT_ARG("%s ", btf__name_by_offset(btf, t->name_off));
>   		break;
>   	case BTF_KIND_STRUCT:
> 
