Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8E645616
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLGJJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 04:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLGJJ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 04:09:27 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB11A818;
        Wed,  7 Dec 2022 01:09:26 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2qQO-000K1N-K3; Wed, 07 Dec 2022 10:09:08 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2qQO-0009Hc-0Y; Wed, 07 Dec 2022 10:09:08 +0100
Subject: Re: [PATCH bpf-next] libbpf: Optimized return value in
 libbpf_strerror when errno is libbpf errno
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
References: <20221203093740.218935-1-liuxin350@huawei.com>
 <6ac9f767-e7f5-6603-6234-97126ea22005@iogearbox.net>
 <CAEf4BzaC6hhNzKkzFa+s4bws7APWj-Nk8Uup+3J6avCXnMFziA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <660fd781-2d86-9d99-2851-127d6b4d4595@iogearbox.net>
Date:   Wed, 7 Dec 2022 10:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaC6hhNzKkzFa+s4bws7APWj-Nk8Uup+3J6avCXnMFziA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26743/Wed Dec  7 09:17:04 2022)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 1:00 AM, Andrii Nakryiko wrote:
> On Mon, Dec 5, 2022 at 1:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 12/3/22 10:37 AM, Xin Liu wrote:
>>> This is a small improvement in libbpf_strerror. When libbpf_strerror
>>> is used to obtain the system error description, if the length of the
>>> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
>>> ERANGE.
>>>
>>> However, this processing is not performed when the error code
>>> customized by libbpf is obtained. Make some minor improvements here,
>>> return -ERANGE and set errno to ERANGE when buf is not enough for
>>> custom description.
>>>
>>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
>>> ---
>>>    tools/lib/bpf/libbpf_errno.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
>>> index 96f67a772a1b..48ce7d5b5bf9 100644
>>> --- a/tools/lib/bpf/libbpf_errno.c
>>> +++ b/tools/lib/bpf/libbpf_errno.c
>>> @@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t size)
>>>
>>>        if (err < __LIBBPF_ERRNO__END) {
>>>                const char *msg;
>>> +             size_t msg_size;
>>>
>>>                msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
>>>                snprintf(buf, size, "%s", msg);
>>>                buf[size - 1] = '\0';
>>> +
>>> +             msg_size = strlen(msg);
>>> +             if (msg_size >= size)
>>> +                     return libbpf_err(-ERANGE);
>>
>> Given this is related to libbpf_strerror_table[] where the error strings are known
>> lets do compile-time error instead. All callers should pass in a buffer of STRERR_BUFSIZE
>> size in libbpf.
> 
> That sounds a bit too pessimistic?.. If the actual error message fits
> in the buffer, why return -ERANGE just because theoretically some
> error descriptions might fit?
> 
> But I don't think we need to calculate strlen(). snprintf above
> returns the number of bytes required to print a full string, even if
> it was truncated. So just comparing snprintf's result to size should
> be enough.

I meant sth like below. For example if we were to shrink STRERR_BUFSIZE down
to 32 for testing, you'd then get:

# make libbpf_errno.o
gcc -g -O2 -std=gnu89 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3 -Wshadow -Wno-switch-enum -Werror -Wall -I. -I/home/darkstar/trees/bpf-next/tools/include -I/home/darkstar/trees/bpf-next/tools/include/uapi -fvisibility=hidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64    -c -o libbpf_errno.o libbpf_errno.c
libbpf_errno.c:27:31: error: initializer-string for array of chars is too long [-Werror]
    27 |  [ERRCODE_OFFSET(KVERSION)] = "'version' section incorrect or lost",
       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf_errno.c:27:31: note: (near initialization for ‘libbpf_strerror_table[2]’)
libbpf_errno.c:31:29: error: initializer-string for array of chars is too long [-Werror]
    31 |  [ERRCODE_OFFSET(VERIFY)] = "Kernel verifier blocks program loading",
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf_errno.c:31:29: note: (near initialization for ‘libbpf_strerror_table[7]’)
libbpf_errno.c:34:31: error: initializer-string for array of chars is too long [-Werror]
    34 |  [ERRCODE_OFFSET(PROGTYPE)] = "Kernel doesn't support this program type",
       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf_errno.c:34:31: note: (near initialization for ‘libbpf_strerror_table[10]’)
libbpf_errno.c:37:30: error: initializer-string for array of chars is too long [-Werror]
    37 |  [ERRCODE_OFFSET(NLPARSE)] = "Incorrect netlink message parsing",
       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
libbpf_errno.c:37:30: note: (near initialization for ‘libbpf_strerror_table[13]’)
cc1: all warnings being treated as errors
make: *** [<builtin>: libbpf_errno.o] Error 1



diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2a82f49ce16f..2e5df1624f79 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -265,8 +265,6 @@ static void pr_perm_msg(int err)
  		buf);
  }

-#define STRERR_BUFSIZE  128
-
  /* Copied from tools/perf/util/util.h */
  #ifndef zfree
  # define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
index 96f67a772a1b..2f03f861b8b6 100644
--- a/tools/lib/bpf/libbpf_errno.c
+++ b/tools/lib/bpf/libbpf_errno.c
@@ -21,7 +21,7 @@
  #define ERRCODE_OFFSET(c)	ERRNO_OFFSET(LIBBPF_ERRNO__##c)
  #define NR_ERRNO	(__LIBBPF_ERRNO__END - __LIBBPF_ERRNO__START)

-static const char *libbpf_strerror_table[NR_ERRNO] = {
+static const char libbpf_strerror_table[NR_ERRNO][STRERR_BUFSIZE] = {
  	[ERRCODE_OFFSET(LIBELF)]	= "Something wrong in libelf",
  	[ERRCODE_OFFSET(FORMAT)]	= "BPF object format invalid",
  	[ERRCODE_OFFSET(KVERSION)]	= "'version' section incorrect or lost",
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..d4dc4fe945a6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -57,6 +57,8 @@
  #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
  #endif

+#define STRERR_BUFSIZE	128
+
  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
  	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
