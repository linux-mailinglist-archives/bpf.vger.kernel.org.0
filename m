Return-Path: <bpf+bounces-9053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1478ED56
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B391C20AE5
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9008F67;
	Thu, 31 Aug 2023 12:38:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5C7481
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 12:38:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A661A4
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:37:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rc10J489Wz4f4XWh
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 20:37:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3kqWgifBkMKsaCA--.29372S2;
	Thu, 31 Aug 2023 20:37:56 +0800 (CST)
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix d_path test
To: Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Hou Tao <houtao1@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20230831110020.290102-1-jolsa@kernel.org>
 <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1f1d6589-5cf7-9d5e-e79e-39347f516e81@huaweicloud.com>
Date: Thu, 31 Aug 2023 20:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3kqWgifBkMKsaCA--.29372S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1kWw45Zw13Cr1DJFy5urg_yoWrWF4fpa
	4kG34UKFyxZF97Kr17CanrWayfGF1DJw48Jr1kta47Zr45Jw1vqF42gw4Ygr1rGrW0vr95
	Z3W2qryI9F17AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/31/2023 7:46 PM, Daniel Borkmann wrote:
> On 8/31/23 1:00 PM, Jiri Olsa wrote:
>> Recent commit [1] broken d_path test, because now filp_close is not
>> called
>> directly from sys_close, but eventually later when the file is finally
>> released.
>>
>> As suggested by Hou Tao we don't need to re-hook the bpf program, but
>> just
>> instead we can use sys_close_range to trigger filp_close synchronously.
>>
>> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
>> Suggested-by: Hou Tao <houtao@huaweicloud.com>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/d_path.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c
>> b/tools/testing/selftests/bpf/prog_tests/d_path.c
>> index 911345c526e6..81e34a4a05d1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
>> @@ -90,7 +90,11 @@ static int trigger_fstat_events(pid_t pid)
>>       fstat(indicatorfd, &fileStat);
>>     out_close:
>> -    /* triggers filp_close */
>> +    /* sys_close no longer triggers filp_close, but we can
>> +     * call sys_close_range instead which still does
>> +     */
>> +#define close(fd) close_range(fd, fd, 0)
>> +
>
> The BPF CI selftest build says:
>
>     [...]
>     TEST-OBJ [test_progs] lookup_key.test.o
>     TEST-OBJ [test_progs] migrate_reuseport.test.o
>     TEST-OBJ [test_progs] user_ringbuf.test.o
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:
> In function ‘trigger_fstat_events’:
>  
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:96:19:
> error: implicit declaration of function ‘close_range’
> [-Werror=implicit-function-declaration]
>      96 | #define close(fd) close_range(fd, fd, 0)
>         |                   ^~~~~~~~~~~
>  
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:98:2:
> note: in expansion of macro ‘close’
>      98 |  close(pipefd[0]);
>         |  ^~~~~
>     TEST-OBJ [test_progs] task_pt_regs.test.o
>     [...]
>
> Perhaps #include <linux/close_range.h> missing ?

Including <linux/close_range.h> doesn't help because it only defines two
macros.

I got the same error when testing locally. It seems close_range() was
introduced by glibc 2.34 [1] and it was defined in <unistd.h>, but the
version of glibc in my local VM is 2.29. I modify d_path locally to call
close_range through syscall():

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c
b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 81e34a4a05d1..c5811843ce7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -12,6 +12,14 @@
 #include "test_d_path_check_rdonly_mem.skel.h"
 #include "test_d_path_check_types.skel.h"

+#ifndef __NR_close_range
+#ifdef __alpha__
+#define __NR_close_range 546
+#else
+#define __NR_close_range 436
+#endif
+#endif
+
 static int duration;

 static struct {
@@ -93,7 +101,7 @@ static int trigger_fstat_events(pid_t pid)
        /* sys_close no longer triggers filp_close, but we can
         * call sys_close_range instead which still does
         */
-#define close(fd) close_range(fd, fd, 0)
+#define close(fd) syscall(__NR_close_range, fd, fd, 0)

[1]: 9b4feb630e8e arch: wire-up close_range()


>
>>       close(pipefd[0]);
>>       close(pipefd[1]);
>>       close(sockfd);
>> @@ -98,6 +102,8 @@ static int trigger_fstat_events(pid_t pid)
>>       close(devfd);
>>       close(localfd);
>>       close(indicatorfd);
>> +
>> +#undef close
>>       return ret;
>>   }
>>  


