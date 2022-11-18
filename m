Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10563001E
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 23:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiKRW3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 17:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiKRW3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 17:29:35 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A779B381;
        Fri, 18 Nov 2022 14:29:26 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ow9rD-00005O-Bk; Fri, 18 Nov 2022 23:29:11 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ow9rC-0006lq-R5; Fri, 18 Nov 2022 23:29:10 +0100
Subject: Re: [PATCH] samples/bpf: Fix duplicate struct define in test_lru_dist
 sample
To:     Liao Chang <liaochang1@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118004752.97759-1-liaochang1@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <109e3d8a-26c6-44c8-aabe-04d5c47ec9c8@iogearbox.net>
Date:   Fri, 18 Nov 2022 23:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221118004752.97759-1-liaochang1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26724/Fri Nov 18 09:51:03 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/22 1:47 AM, Liao Chang wrote:
> Build sample/bpf report error as follow:
> 
>    CC  ./samples/bpf/test_lru_dist
> ./samples/bpf/test_lru_dist.c:35:8: error: redefinition of ‘struct list_head’
>     35 | struct list_head {
>        |        ^~~~~~~~~
> In file included from ./samples/bpf/test_lru_dist.c:6:
> ./tools/include/linux/types.h:84:8: note: originally defined here
>     84 | struct list_head {
> 
> Remove the duplicate definition of struct list_head in test_lru_dist.c
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>   samples/bpf/test_lru_dist.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
> index 5efb91763d65..2e7341044090 100644
> --- a/samples/bpf/test_lru_dist.c
> +++ b/samples/bpf/test_lru_dist.c
> @@ -32,10 +32,6 @@ static int nr_cpus;
>   static unsigned long long *dist_keys;
>   static unsigned int dist_key_counts;
>   
> -struct list_head {
> -	struct list_head *next, *prev;
> -};
> -

This will actually break it, see CI:

https://github.com/kernel-patches/bpf/actions/runs/3500019006/jobs/5862316961

   [...]
   CLANG-bpf  /tmp/work/bpf/bpf/samples/bpf/lathist_kern.o
     CLANG-bpf  /tmp/work/bpf/bpf/samples/bpf/offwaketime_kern.o
     CLANG-bpf  /tmp/work/bpf/bpf/samples/bpf/spintest_kern.o
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:35:42: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      35 | static inline void INIT_LIST_HEAD(struct list_head *list)
         |                                          ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘INIT_LIST_HEAD’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:37:6: error: dereferencing pointer to incomplete type ‘struct list_head’
      37 |  list->next = list;
         |      ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:41:43: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      41 | static inline int list_empty(const struct list_head *head)
         |                                           ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘list_empty’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:43:13: error: dereferencing pointer to incomplete type ‘const struct list_head’
      43 |  return head->next == head;
         |             ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:46:38: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      46 | static inline void __list_add(struct list_head *new,
         |                                      ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘__list_add’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:50:6: error: dereferencing pointer to incomplete type ‘struct list_head’
      50 |  next->prev = new;
         |      ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:56:36: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      56 | static inline void list_add(struct list_head *new, struct list_head *head)
         |                                    ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘list_add’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:58:28: error: dereferencing pointer to incomplete type ‘struct list_head’
      58 |  __list_add(new, head, head->next);
     CLANG-bpf  /tmp/work/bpf/bpf/samples/bpf/map_perf_test_kern.o
         |                            ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:58:13: warning: passing argument 1 of ‘__list_add’ from incompatible pointer type [-Wincompatible-pointer-types]
      58 |  __list_add(new, head, head->next);
         |             ^~~
         |             |
         |             struct list_head *
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:46:49: note: expected ‘struct list_head *’ but argument is of type ‘struct list_head *’
      46 | static inline void __list_add(struct list_head *new,
         |                               ~~~~~~~~~~~~~~~~~~^~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:58:18: warning: passing argument 2 of ‘__list_add’ from incompatible pointer type [-Wincompatible-pointer-types]
      58 |  __list_add(new, head, head->next);
         |                  ^~~~
         |                  |
         |                  struct list_head *
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:47:28: note: expected ‘struct list_head *’ but argument is of type ‘struct list_head *’
      47 |          struct list_head *prev,
         |          ~~~~~~~~~~~~~~~~~~^~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:61:38: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      61 | static inline void __list_del(struct list_head *prev, struct list_head *next)
         |                                      ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘__list_del’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:63:6: error: dereferencing pointer to incomplete type ‘struct list_head’
      63 |  next->prev = prev;
         |      ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:67:44: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      67 | static inline void __list_del_entry(struct list_head *entry)
         |                                            ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘__list_del_entry’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:69:18: error: dereferencing pointer to incomplete type ‘struct list_head’
      69 |  __list_del(entry->prev, entry->next);
         |                  ^~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:72:37: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
      72 | static inline void list_move(struct list_head *list, struct list_head *head)
         |                                     ^~~~~~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: In function ‘list_move’:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:74:19: warning: passing argument 1 of ‘__list_del_entry’ from incompatible pointer type [-Wincompatible-pointer-types]
      74 |  __list_del_entry(list);
         |                   ^~~~
         |                   |
         |                   struct list_head *
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:67:55: note: expected ‘struct list_head *’ but argument is of type ‘struct list_head *’
      67 | static inline void __list_del_entry(struct list_head *entry)
         |                                     ~~~~~~~~~~~~~~~~~~^~~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:75:11: warning: passing argument 1 of ‘list_add’ from incompatible pointer type [-Wincompatible-pointer-types]
      75 |  list_add(list, head);
         |           ^~~~
         |           |
         |           struct list_head *
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:56:47: note: expected ‘struct list_head *’ but argument is of type ‘struct list_head *’
      56 | static inline void list_add(struct list_head *new, struct list_head *head)
         |                             ~~~~~~~~~~~~~~~~~~^~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:75:17: warning: passing argument 2 of ‘list_add’ from incompatible pointer type [-Wincompatible-pointer-types]
      75 |  list_add(list, head);
         |                 ^~~~
         |                 |
         |                 struct list_head *
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:56:70: note: expected ‘struct list_head *’ but argument is of type ‘struct list_head *’
      56 | static inline void list_add(struct list_head *new, struct list_head *head)
         |                                                    ~~~~~~~~~~~~~~~~~~^~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c: At top level:
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:85:19: error: field ‘list’ has incomplete type
      85 |  struct list_head list;
         |                   ^~~~
   /tmp/work/bpf/bpf/samples/bpf/test_lru_dist.c:90:19: error: field ‘list’ has incomplete type
      90 |  struct list_head list;
         |                   ^~~~
     CLANG-bpf  /tmp/work/bpf/bpf/samples/bpf/test_overhead_tp_kern.o
   make[3]: *** [/tmp/work/bpf/bpf/samples/bpf/Makefile.target:58: /tmp/work/bpf/bpf/samples/bpf/test_lru_dist] Error 1
   make[3]: *** Waiting for unfinished jobs....
     LD      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/libbpf/staticobjs/libbpf-in.o
     LINK    /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/libbpf/libbpf.a
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/main.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/common.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/json_writer.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/gen.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/btf.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/xlated_dumper.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/btf_dumper.o
     CC      /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/disasm.o
     LINK    /tmp/work/bpf/bpf/samples/bpf/bpftool/bootstrap/bpftool
   make[2]: *** [/tmp/work/bpf/bpf/Makefile:1992: /tmp/work/bpf/bpf/samples/bpf] Error 2
   make[2]: Leaving directory '/tmp/work/bpf/bpf/kbuild-output'
   make[1]: *** [Makefile:231: __sub-make] Error 2
   make[1]: Leaving directory '/tmp/work/bpf/bpf'
   make: *** [Makefile:269: all] Error 2
   make: Leaving directory '/tmp/work/bpf/bpf/samples/bpf'
   Error: Process completed with exit code 2.
