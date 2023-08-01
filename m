Return-Path: <bpf+bounces-6540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7076AAB9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41F81C20DE7
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42C1ED33;
	Tue,  1 Aug 2023 08:17:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFC1110
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:17:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFBF19BD;
	Tue,  1 Aug 2023 01:17:33 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFScY0lz9z1GDHX;
	Tue,  1 Aug 2023 16:16:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 16:17:28 +0800
Message-ID: <f6be0749-28fd-224f-5eb0-ebad99cafa4a@huawei.com>
Date: Tue, 1 Aug 2023 16:17:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2] selftests/bpf: replace fall through comment by
 fallthrough pseudo-keyword
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>
CC: <Ast@kernel.org>, <Daniel@iogearbox.net>, <Andrii@kernel.org>,
	<Mykolal@fb.com>, <Martin.lau@linux.dev>, <Song@kernel.org>,
	<Yonghong.song@linux.dev>, <John.fastabend@gmail.com>, <Kpsingh@kernel.org>,
	<Sdf@google.com>, <Haoluo@google.com>, <Jolsa@kernel.org>,
	<Shuah@kernel.org>, <Benjamin.tissoires@redhat.com>, <Asavkov@redhat.com>,
	<Iii@linux.ibm.com>, <Memxor@gmail.com>, <Colin.i.king@gmail.com>,
	<Rdunlap@infradead.org>, <Awkrail01@gmail.com>, <Joannelkoong@gmail.com>,
	<linux-kselftest@vger.kernel.org>
References: <20230801065447.3609130-1-ruanjinjie@huawei.com>
 <11895d11-9f2c-249b-abd3-f5226a5be3f5@huaweicloud.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <11895d11-9f2c-249b-abd3-f5226a5be3f5@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/1 15:38, Hou Tao wrote:
> Hi,
> 
> On 8/1/2023 2:54 PM, Ruan Jinjie wrote:
>> Replace the existing /* fall through */ comments with the
>> new pseudo-keyword macro fallthrough[1].
>>
>> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Update the subject and commit message.
> 
> According to the section "How do I indicate which tree (bpf vs.
> bpf-next) my patch should be applied to" in
> Documentation/bpf/bpf_devel_QA.rst, the subject prefix should be [PATCH
> bpf-next].
>> ---
>>  tools/testing/selftests/bpf/prog_tests/kfunc_call.c          | 4 ++--
>>  tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
>>  tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
>>  tools/testing/selftests/bpf/test_verifier.c                  | 2 +-
>>  4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> index a543742cd7bd..0fd08172965a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> @@ -101,7 +101,7 @@ static void verify_success(struct kfunc_test_params *param)
>>  	case syscall_test:
>>  		topts.ctx_in = &args;
>>  		topts.ctx_size_in = sizeof(args);
>> -		/* fallthrough */
>> +		fallthrough;
>>  	case syscall_null_ctx_test:
>>  		break;
>>  	case tc_test:
>> @@ -167,7 +167,7 @@ static void verify_fail(struct kfunc_test_params *param)
>>  	case syscall_test:
>>  		topts.ctx_in = &args;
>>  		topts.ctx_size_in = sizeof(args);
>> -		/* fallthrough */
>> +		fallthrough;
>>  	case syscall_null_ctx_test:
>>  		break;
>>  	case tc_test:
>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> index 66b304982245..f97960759558 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> @@ -300,7 +300,7 @@ bool pkt_skip_ipv6_extension_headers(buf_t *pkt,
>>  		case IPPROTO_FRAGMENT:
>>  			*is_fragment = true;
>>  			/* NB: We don't check that hdrlen == 0 as per spec. */
>> -			/* fallthrough; */
>> +			fallthrough;
> 
> The build of test_progs failed as shown below. Have you tested your
> patch locally ?
> 
> progs/test_cls_redirect.c:292:4: In file included from
> progs/test_cls_redirect_subprogs.cerror: :2:
> use of undeclared identifier 'fallthrough'
> progs/test_cls_redirect.c:292:4: error: use of undeclared identifier
> 'fallthrough'

Thank you very much! I will fix it in v3

>                         fallthrough;
>                         ^
>                         fallthrough;
>                         ^
> 
> 
>>  
>>  		case IPPROTO_HOPOPTS:
>>  		case IPPROTO_ROUTING:
>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> index f41c81212ee9..54dbf307c692 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> @@ -204,7 +204,7 @@ static bool pkt_skip_ipv6_extension_headers(struct bpf_dynptr *dynptr, __u64 *of
>>  		case IPPROTO_FRAGMENT:
>>  			*is_fragment = true;
>>  			/* NB: We don't check that hdrlen == 0 as per spec. */
>> -			/* fallthrough; */
>> +			fallthrough;
>>  
>>  		case IPPROTO_HOPOPTS:
>>  		case IPPROTO_ROUTING:
>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
>> index 31f1c935cd07..5621a4e0a1be 100644
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -1289,7 +1289,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>>  				printf("Did not run the program (no permission) ");
>>  				return 0;
>>  			}
>> -			/* fallthrough; */
>> +			fallthrough;
>>  		default:
>>  			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ",
>>  				strerror(saved_errno));
> 

