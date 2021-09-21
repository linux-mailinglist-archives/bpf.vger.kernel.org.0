Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B509412E27
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 07:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhIUFWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 01:22:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18284 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhIUFWf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 01:22:35 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwIB7028481;
        Mon, 20 Sep 2021 22:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6N8kc8szwkz9dLGZ9V1vX/nlOhgNc6PdOdN3oyB17/A=;
 b=QD5B8/r7g0SdjFneXudiErfrfcbrRpPiw02H/YQlWX5HCNph5YEw6rFOI5DYgbcvVPur
 EL5fDcLndXDOXfeV5BxvQOkHsQnIbJH+yrQjsDh4mGv6VLUZQrWupHHcioq9FrFCGoL3
 /XJEyPdcjcgHpQ96EULnwnEGQGOG29s0JFw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6kt678fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Sep 2021 22:20:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 22:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCHXj9Pi/NfTdC9NvQXlqjakJbedbJhyTInZP7pzfAgXH7s5RiKnl1wt+kJ3XAUZsc3WiIy8nUaJtajTDLlJc8KcE0AVv/U9O1LPOh+IMdRMxIgBWA3kzPCmMz++WRsqGRX6tZmhnXFODFYUjNDEOo/N/d9e+nkHRs+aQHvCvHmB0R2uvr7fYkatrY1DHLbduE0RO5JSQ11iWI2LsSTCzF7okLjZgKaKR4KV3a0Aza8gKora51DYKhAd7rh8+B53ME5spYwVomm6J6qkKinvGE0JrSl7xUtL5wPP4Vcl+4bsj5dcfmzr2wxMx7V2mS3Z1vCkrXLQcQUBLepfB0g1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6N8kc8szwkz9dLGZ9V1vX/nlOhgNc6PdOdN3oyB17/A=;
 b=XbC8L1v+MGX7VrVQ7lPU/OIdehhj1S3DmwtwnvjoNBEZo0WgDHJKaZZp22C6Qd8jkfXu+rjIJo8hiEqj4rPqBLhsazRqYH3R1B2hps75qCnevdbq+Q31K7orh+JwS76ES407ZbFUBR1Jklm3SohR/xDW2+/RpFijzC/qtbvUvYYo0UAX1dJqoxjUEfnDROIvRubJ+2lu5GyvyEjlQB0Badtk5nL/GH2ZMJ5IlMHR9oQaZzSHLw5acGyRTEuErYbWaqDWeVf1N2POt0alkzytz9IzQ3aYSeaOqi9HQhAYVUHOBSOtfu1bcPp5lziwPGsJagkDRLnxAhf/q4PBwMj+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2604.namprd15.prod.outlook.com (2603:10b6:5:1a4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 05:20:50 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 05:20:50 +0000
Message-ID: <f89e5325-0096-6239-98bf-0da6a489e3fd@fb.com>
Date:   Tue, 21 Sep 2021 01:20:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:208:235::13) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::10ab] (2620:10d:c091:480::1:7a32) by MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 05:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20473ee-0f74-479a-b4ae-08d97cbf9365
X-MS-TrafficTypeDiagnostic: DM6PR15MB2604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB2604222770E51A1936A548F5A0A19@DM6PR15MB2604.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adw7rAhYhFEXu7lVR3DdusHWNiwkvI/vP1wIje370vkSXWkO113rZpKCrqAEW4nzwEuDX+WY8mgipNDuI99/E4vJCRrevG4MkCLOrEtUJAsbV3jn1l66Ig2Sc45zn9KhEJlCYJC+mHs2uixltIAeO9WofpTPbWxmog/b1oji7qs5h0Ym9dcMRUf5p9LfUJw0FxoCT6h6XfOl0aClFxVXIDut3g635fFfgxK07Ibz64SJmZkDQVfi3f7sin4zC1awkgbxQXO5fDuGuIC955yg2s3mqKeT1fJtb414CO7n/w4/rVcDo5fArWrNm3PU+yU82ARziggYDO+bG1sPLn/cItolCyQUR4XFSgiQBwJDbjYidsRetIxExZO3ZRrfSEHESPGsv4mtnBX9xny28uUyabLrS25IMr3EBduUsJ3Z5+GxHGe4TeFdeD8XQzjakxCB6w1aATk4WXomibzUPYZ6LAU9nnT4juTQohlIpkqJS0AJhPcSicKZ8aMQs7mY4qYpjhrZbB/kHcbHyaFZ+eQnf+CHPtMDsfyB7KPw020IV3SSAq+AD/tz7xauZx+V7sTuHtMR6pR9TdsuqovFe5D3+2jC7VMaMsAWg8dJ1cyZSiA1+9PPb7pyy+VF8lC6+Ri9t+JuxV71Bx/I3ULQXntVV0G3/ax4TZfPEiIERPpt/7pusx7in72ugNDtjB3FR2GLuqHSIzgzU2WNP+VoWTSYXm3Pc01x67Du833KWK9VYQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(36756003)(316002)(508600001)(8936002)(2906002)(4326008)(53546011)(8676002)(2616005)(66556008)(31686004)(66476007)(38100700002)(31696002)(83380400001)(5660300002)(6486002)(186003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0pBRThpRzBKRDhFMGp5OXVkYTU5ZzdEYjBGMHExa1VzM3NwTENYVStLUk1C?=
 =?utf-8?B?SUV1eTg5K251ZTg4aUEvMm4yZHpUL0lGU092endqaHkyc2ZvSG1oejlsanRJ?=
 =?utf-8?B?UjR6MDdVUmlBcXNFY3FyL2xUVGw5YkZwdGZXMFJKVkFvYkhkcXRnWVI2YXBZ?=
 =?utf-8?B?eTFtNWsvTzNtc0VtbE9HemZObzUxSVVrenRoN0wxNXNzek8zSEY1dEU4c2hT?=
 =?utf-8?B?L3pOR3oyTHZ2SmMvMGNFaTVCUUI2S040SEpXcm5henprTTdJQ3ZDQXo1NVlW?=
 =?utf-8?B?cHhNRjdTVUxCMEF5UG8wbXpNQlZWVGZLOFdYMksvQ3hqdnlJSUJaNHJialBy?=
 =?utf-8?B?N0t6aWRPTnJhM2N0bkZ6ZUhKaktEU05WdzdlSHlvYis3cm5vOFJ5cmFVS3dR?=
 =?utf-8?B?WEZSZityUEtSTnIrK1VsUVBRZjEydmZyRTV5VWpMekRVenFNbSs4d3VlcDFB?=
 =?utf-8?B?SDQ4Ly93VDBaSWhvWUFEYklyVzI3V1dWWGhPc0ozeGdFQVVNaXFKNElDT1VP?=
 =?utf-8?B?d0pUYlRGNXdXMDVjc0h2dHMxVkU4OGtiSjVxdkk0WUNMY1hJVWU1UnMzcUZU?=
 =?utf-8?B?YXhSTitVano3RUlvbC9tMVlGYTlZVGR6RjBjbVlyaTU3WUNxd0ljOVFYeng5?=
 =?utf-8?B?Umttc0Zac3ViYkgzdzF2U3VZTDA0Tk5zakRiMGJCQm9pYTAxOUJMUVEzRFBp?=
 =?utf-8?B?Y2RvTzRoZHhoZ25ieGllSmQrS1VsRUZzQTlwa2l1SzFXZ2tHSG5vZFdvUy9s?=
 =?utf-8?B?MDRQeFFwY21iVVRDN0ltYlAydCs4VUFBNS95SmNYNmMxTE50bHM5K3p5VkI5?=
 =?utf-8?B?M1g1Y0lZZFM5bnhzWUlrMmRwVXhtc0o4T3NSZEJTRUJJWWpJa3p5amVGd0cy?=
 =?utf-8?B?Tjc1TlIrSDducUhvWjZxQkh0ZmJOVUtqbEl1dm16dkVhb2x3U1JTKzhCU3Jo?=
 =?utf-8?B?bkR5U1BQZWJlc0ZmZmJWWlJKTkhMMk9mUlphME1CbS8zNEhpS0RhemlLVFBt?=
 =?utf-8?B?Y2lhSXVmdGJoQ2tmRmZCUHgyb0dGTnJHTnhWeEpORlA0K0ZKSlh2MlFJZ3Rr?=
 =?utf-8?B?akpXS0orRXludXdicmk2K2lyYVArSlVmOHB2ZXp6cDZobUNheVR5TWEvekpF?=
 =?utf-8?B?MWtLL29Nc2lFUkdxY3U0WGZoa3FwQVRac1RJMm5ja0pvMC9KR3QyZFI4cDdB?=
 =?utf-8?B?amhOTkkzUnpXRU5VRHN3c2VWWlp6WFg3QTVsSnhTL2FyYVBDYWpQSGdmdEZ4?=
 =?utf-8?B?WkpkdE81TFMxQ1RFWnlvS2k5WG9RZ00yNmJvUTlra0NyYVpOa010OGJFYTlk?=
 =?utf-8?B?elZMemFZdHgxREVNS05vWHl6bWRiL0hHSDg5V3VKTFZ2bk94QjJnR3FIa0pX?=
 =?utf-8?B?Mlh4ZmRoRjJYNnRjMS92MTZ5QWpyWVM5Vm9rb2JPOHBZRkt3OEFpM3IzRklQ?=
 =?utf-8?B?VmQraFFUMGt0OThHSlhnRnF6ai8vaVJBZmlKUUh5M2hUdjdxU3IrTEFvdjdS?=
 =?utf-8?B?QzFCbFZUaEJycndkR2cwMDJpRjY4TGN3ZGlDOUNyRkQ4bldIRllGTlJ4Yjlo?=
 =?utf-8?B?LzdidjEySVA1Ync0UkhpakVXK2Z2Q2lkMVJmZExYckUxcEsweGVma2xDQUlT?=
 =?utf-8?B?V1VoVGx5M1A1STMvYlhaQTVoZ1dLaDZHd2tQVEc4QTJJRGRvcG1JU2lKR0FQ?=
 =?utf-8?B?Smt2aklJakRmZGNJUXBVVk5wd2twQ1FqY0l3YnpaWW1yM2ZtUnFhaE9qL3I1?=
 =?utf-8?B?R2tTclBkRlczS0NGNUdrRUxPSUpoUFZJd01MVllzWG5XSmJHNkJzZHdOajJH?=
 =?utf-8?B?cHY2dmp2enE3dWdmaURkUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e20473ee-0f74-479a-b4ae-08d97cbf9365
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 05:20:50.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bHCqmArId9wnlyNY+ec23Z6Mo4/iPylBTT2TxDFRnmjTlMciJ88Git6PgiOtFrbdYidBT2VAgD2TPiZAvkfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2604
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8ee0wI-s7omP0rdSq0-xU0pUu6RDLzf0
X-Proofpoint-GUID: 8ee0wI-s7omP0rdSq0-xU0pUu6RDLzf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> extra characters. In reference_tracking selftests also drop the usage of
> broken bpf_program__load(). Along the way switch from ambiguous searching by
> program title (section name) to non-ambiguous searching by name in some
> selftests, getting closer to completely removing
> bpf_object__find_program_by_title().
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Looks like you feel similarly about the SEC("version") comment from patch 1.

>  .../bpf/prog_tests/reference_tracking.c       | 22 ++++---
>  .../selftests/bpf/prog_tests/sk_assign.c      |  2 +-
>  .../selftests/bpf/prog_tests/tailcalls.c      | 58 +++++++++----------
>  .../testing/selftests/bpf/progs/skb_pkt_end.c |  2 +-
>  tools/testing/selftests/bpf/progs/tailcall1.c |  5 +-
>  tools/testing/selftests/bpf/progs/tailcall2.c | 21 ++++---
>  tools/testing/selftests/bpf/progs/tailcall3.c |  5 +-
>  tools/testing/selftests/bpf/progs/tailcall4.c |  5 +-
>  tools/testing/selftests/bpf/progs/tailcall5.c |  5 +-
>  tools/testing/selftests/bpf/progs/tailcall6.c |  4 +-
>  .../selftests/bpf/progs/tailcall_bpf2bpf1.c   |  5 +-
>  .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 +-
>  .../selftests/bpf/progs/tailcall_bpf2bpf3.c   |  9 ++-
>  .../selftests/bpf/progs/tailcall_bpf2bpf4.c   | 13 ++---
>  .../bpf/progs/test_btf_skc_cls_ingress.c      |  2 +-
>  .../selftests/bpf/progs/test_cls_redirect.c   |  2 +-
>  .../selftests/bpf/progs/test_global_data.c    |  2 +-
>  .../selftests/bpf/progs/test_global_func1.c   |  2 +-
>  .../selftests/bpf/progs/test_global_func3.c   |  2 +-
>  .../selftests/bpf/progs/test_global_func5.c   |  2 +-
>  .../selftests/bpf/progs/test_global_func6.c   |  2 +-
>  .../selftests/bpf/progs/test_global_func7.c   |  2 +-
>  .../selftests/bpf/progs/test_pkt_access.c     |  2 +-
>  .../selftests/bpf/progs/test_pkt_md_access.c  |  4 +-
>  .../selftests/bpf/progs/test_sk_assign.c      |  3 +-
>  .../selftests/bpf/progs/test_sk_lookup_kern.c | 37 ++++++------
>  .../selftests/bpf/progs/test_skb_helpers.c    |  2 +-
>  .../selftests/bpf/progs/test_sockmap_update.c |  2 +-
>  .../selftests/bpf/progs/test_tc_neigh.c       |  6 +-
>  .../selftests/bpf/progs/test_tc_neigh_fib.c   |  6 +-
>  .../selftests/bpf/progs/test_tc_peer.c        | 10 ++--
>  31 files changed, 117 insertions(+), 132 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> index ded2dc8ddd79..836b8bf17fff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
> @@ -2,14 +2,14 @@
>  #include <test_progs.h>
>  
>  static void toggle_object_autoload_progs(const struct bpf_object *obj,
> -					 const char *title_load)
> +					 const char *name_load)
>  {
>  	struct bpf_program *prog;
>  
>  	bpf_object__for_each_program(prog, obj) {
> -		const char *title = bpf_program__section_name(prog);
> +		const char *name = bpf_program__name(prog);
>  
> -		if (!strcmp(title_load, title))
> +		if (!strcmp(name_load, name))
>  			bpf_program__set_autoload(prog, true);
>  		else
>  			bpf_program__set_autoload(prog, false);
> @@ -39,23 +39,20 @@ void test_reference_tracking(void)
>  		goto cleanup;
>  
>  	bpf_object__for_each_program(prog, obj_iter) {
> -		const char *title;
> +		const char *name;
>  
>  		/* Ignore .text sections */

I think this comment should go as well, no longer helps understand the test
