Return-Path: <bpf+bounces-14291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB397E227D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2D228158C
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918151F5E6;
	Mon,  6 Nov 2023 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RPEXEnW5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF41D55E
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:56:05 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D1EA
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 04:56:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so7294552a12.2
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699275361; x=1699880161; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=L0QDp7lDNm2awtfWGTyxjy2wjiWlEOGoI1KRYuRJul0=;
        b=RPEXEnW50SlVksqKeddT9r/I7jVWDxrUL77L8U8GSZQJaECAoFy7aUDFzV88rGCyla
         6lXHGmgKc5Udli3O+7vkV0TKCk9agrCQ56u86vCvQQtCTd3vHI9fI/GELNmppBcbxf29
         gtShGYONk86EO7feHj98PzvdzIA/pbwlBg7XYBsOio/G5MzprExrWoGPXJQ+4VuDLqov
         1vfkXx3jhoKE0/wEyRF7EllK6HuOdWAPQI4zFpxGUaZ4rVXDRgCT8XD6r1gMjt7KTgMl
         SSlubwRr8cGoq0jAl9cVrwUnj7Ll5LP489heJg6B3f7KS/mj4WAdmW0i2k+0yEQNWByA
         V6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699275361; x=1699880161;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0QDp7lDNm2awtfWGTyxjy2wjiWlEOGoI1KRYuRJul0=;
        b=OXmYjsMplBRpHbiwhnQ0ReoQFAfd0AA0idUjeKO+r4pA/7DQ7ow1lZqIO3REY36tBz
         7JGwq6WkInw+EZe3BK5o7G9N9Ks0bea6sUiWJXwVyVOzDDbaxdQ2l10Fvl7xsJ0nRbIU
         rPf0wBgvgGW1QD2dzspTfpq86u6zi6WDgxxJqUGRZYcIzxnDplBuDyglo6xb2IlCq5KH
         MaqE2dox22FYSqsMDNvFKryXyYKzsGydgb2taK4anh3HWOe/zmdgN2wE+sPyIt7Z1twg
         yDZK2Cc27fq4n6o3JkJGzhl3V2sjJAWGy08mIAQBK9hhWeLHpQqIETbY9LuUWq7vsdBr
         4Mrw==
X-Gm-Message-State: AOJu0Yx+FZs+U/DaXDr6T6qUvNYOxkLW3uGK26rAMNajM5LpjZr5/4/b
	jjfZen6bUQRENoeEQHffsor0wQ==
X-Google-Smtp-Source: AGHT+IEK9xAG0OO54pTq/PDlgp34o5FMpHAKig7XDWe/DsyWYd0GoOEyjbu4pXAmh7udm7nMwiB9gA==
X-Received: by 2002:aa7:d8d2:0:b0:543:5789:4d6c with SMTP id k18-20020aa7d8d2000000b0054357894d6cmr14841243eds.2.1699275361576;
        Mon, 06 Nov 2023 04:56:01 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id m22-20020a509316000000b0053e88c4d004sm4385852eda.66.2023.11.06.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:56:00 -0800 (PST)
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: sockmap, add af_unix test with both
 sockets in map
Date: Mon, 06 Nov 2023 13:44:02 +0100
In-reply-to: <20231016190819.81307-3-john.fastabend@gmail.com>
Message-ID: <878r7bjb1a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> This adds a test where both pairs of a af_unix paired socket are put into
> a BPF map. This ensures that when we tear down the af_unix pair we don't
> have any issues on sockmap side with ordering and reference counting.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
>  .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 8df8cbb447f1..90e97907c1c1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1824,8 +1824,10 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
>  }
>  
> -static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
> -					int verd_mapfd, enum redir_mode mode)
> +static void unix_inet_redir_to_connected(int family, int type,
> +					int sock_mapfd, int nop_mapfd,
> +					int verd_mapfd,
> +					enum redir_mode mode)
>  {
>  	const char *log_prefix = redir_mode_str(mode);
>  	int c0, c1, p0, p1;
> @@ -1849,6 +1851,12 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
>  	if (err)
>  		goto close;
>  
> +	if (nop_mapfd >= 0) {
> +		err = add_to_sockmap(nop_mapfd, c0, c1);
> +		if (err)
> +			goto close;
> +	}
> +
>  	n = write(c1, "a", 1);
>  	if (n < 0)
>  		FAIL_ERRNO("%s: write", log_prefix);
> @@ -1883,6 +1891,7 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  					    struct bpf_map *inner_map, int family)
>  {
>  	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
> +	int nop_map = bpf_map__fd(skel->maps.nop_map);
>  	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
>  	int sock_map = bpf_map__fd(inner_map);
>  	int err;
> @@ -1892,14 +1901,32 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  		return;
>  
>  	skel->bss->test_ingress = false;
> -	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
> +	unix_inet_redir_to_connected(family, SOCK_DGRAM,
> +				     sock_map, -1, verdict_map,
> +				     REDIR_EGRESS);
> +	unix_inet_redir_to_connected(family, SOCK_DGRAM,
> +				     sock_map, -1, verdict_map,
>  				     REDIR_EGRESS);
> -	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
> +
> +	unix_inet_redir_to_connected(family, SOCK_DGRAM,
> +				     sock_map, nop_map, verdict_map,
> +				     REDIR_EGRESS);
> +	unix_inet_redir_to_connected(family, SOCK_STREAM,
> +				     sock_map, nop_map, verdict_map,
>  				     REDIR_EGRESS);
>  	skel->bss->test_ingress = true;
> -	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
> +	unix_inet_redir_to_connected(family, SOCK_DGRAM,
> +				     sock_map, -1, verdict_map,
> +				     REDIR_INGRESS);
> +	unix_inet_redir_to_connected(family, SOCK_STREAM,
> +				     sock_map, -1, verdict_map,
> +				     REDIR_INGRESS);
> +
> +	unix_inet_redir_to_connected(family, SOCK_DGRAM,
> +				     sock_map, nop_map, verdict_map,
>  				     REDIR_INGRESS);
> -	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
> +	unix_inet_redir_to_connected(family, SOCK_STREAM,
> +				     sock_map, nop_map, verdict_map,
>  				     REDIR_INGRESS);
>  
>  	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
> index 464d35bd57c7..b7250eb9c30c 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
> @@ -14,6 +14,13 @@ struct {
>  	__type(value, __u64);
>  } sock_map SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 2);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} nop_map SEC(".maps");
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_SOCKHASH);
>  	__uint(max_entries, 2);

So... we have a bug in unix_inet_redir_to_connected() - it happily
ignores the passed socket type, which is currently hardcoded to
SOCK_DGRAM :-)

Which means these tests don't exercise unix_stream paths where the added
psock->skpair is actually needed.

But I'm able to reproduce the bug by running the VSOCK redir test:

bash-5.2# ./test_progs -n 212/79
[   23.232282] ==================================================================
[   23.232634] BUG: KASAN: slab-use-after-free in sock_def_readable+0xe3/0x400
[   23.232942] Read of size 8 at addr ffff8881013f9860 by task kworker/1:2/220
[   23.233253]
[   23.233326] CPU: 1 PID: 220 Comm: kworker/1:2 Tainted: G           OE      6.6.0 #30
[   23.233697] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[   23.234074] Workqueue: events sk_psock_backlog
[   23.234271] Call Trace:
[   23.234381]  <TASK>
[   23.234477]  dump_stack_lvl+0x4a/0x90
[   23.234640]  print_address_description.constprop.0+0x33/0x400
[   23.234888]  ? preempt_count_sub+0x13/0xc0
[   23.235071]  print_report+0xb6/0x260
[   23.235228]  ? kasan_complete_mode_report_info+0x7c/0x1f0
[   23.235462]  kasan_report+0xd0/0x110
[   23.235619]  ? sock_def_readable+0xe3/0x400
[   23.235801]  ? sock_def_readable+0xe3/0x400
[   23.235989]  kasan_check_range+0xf7/0x1b0
[   23.236164]  __kasan_check_read+0x11/0x20
[   23.236340]  sock_def_readable+0xe3/0x400
[   23.236514]  unix_stream_sendmsg+0x3c5/0x7d0
[   23.236704]  ? queue_oob+0x300/0x300
[   23.236865]  sock_sendmsg+0x229/0x250
[   23.237030]  ? sock_write_iter+0x320/0x320
[   23.237211]  ? __this_cpu_preempt_check+0x13/0x20
[   23.237416]  ? lock_acquire+0x191/0x410
[   23.237607]  ? lock_sync+0x110/0x110
[   23.237766]  ? lock_is_held_type+0xd0/0x130
[   23.237948]  ? __asan_storeN+0x12/0x20
[   23.238115]  __skb_send_sock+0x4fa/0x670
[   23.238288]  ? preempt_count_sub+0x13/0xc0
[   23.238494]  ? sendmsg_locked+0x90/0x90
[   23.238721]  ? sendmsg_unlocked+0x40/0x40
[   23.238975]  ? __lock_acquire+0x765/0xf00
[   23.239252]  ? __this_cpu_preempt_check+0x13/0x20
[   23.239570]  ? lock_acquire+0x191/0x410
[   23.239831]  skb_send_sock+0x10/0x20
[   23.240079]  sk_psock_backlog+0x141/0x5e0
[   23.240340]  ? __this_cpu_preempt_check+0x13/0x20
[   23.240638]  process_one_work+0x49d/0x970
[   23.240900]  ? drain_workqueue+0x1c0/0x1c0
[   23.241173]  ? assign_work+0xe1/0x120
[   23.241404]  worker_thread+0x380/0x680
[   23.241660]  ? trace_hardirqs_on+0x22/0x100
[   23.241933]  ? preempt_count_sub+0x13/0xc0
[   23.242213]  ? process_one_work+0x970/0x970
[   23.242491]  kthread+0x1ba/0x200
[   23.242687]  ? kthread+0xfe/0x200
[   23.242890]  ? kthread_complete_and_exit+0x20/0x20
[   23.243193]  ret_from_fork+0x35/0x60
[   23.243418]  ? kthread_complete_and_exit+0x20/0x20
[   23.243718]  ret_from_fork_asm+0x11/0x20
[   23.243995]  </TASK>
[   23.244145]
[   23.244227] Allocated by task 227:
[   23.244446]  kasan_save_stack+0x26/0x50
[   23.244709]  kasan_set_track+0x25/0x40
[   23.244951]  kasan_save_alloc_info+0x1e/0x30
[   23.245220]  __kasan_slab_alloc+0x72/0x80
[   23.245491]  kmem_cache_alloc+0x182/0x360
[   23.245758]  sk_prot_alloc+0x43/0x160
[   23.246007]  sk_alloc+0x2c/0x3a0
[   23.246216]  unix_create1+0x86/0x440
[   23.246462]  unix_create+0x7d/0x100
[   23.246701]  __sock_create+0x1bc/0x420
[   23.246960]  __sys_socketpair+0x1ac/0x3a0
[   23.247237]  __x64_sys_socketpair+0x4f/0x60
[   23.247521]  do_syscall_64+0x38/0x90
[   23.247769]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   23.248113]
[   23.248225] Freed by task 227:
[   23.248444]  kasan_save_stack+0x26/0x50
[   23.248707]  kasan_set_track+0x25/0x40
[   23.248963]  kasan_save_free_info+0x2b/0x50
[   23.249249]  ____kasan_slab_free+0x154/0x1c0
[   23.249541]  __kasan_slab_free+0x12/0x20
[   23.249810]  kmem_cache_free+0x1e7/0x480
[   23.250084]  __sk_destruct+0x270/0x3f0
[   23.250342]  sk_destruct+0x78/0x90
[   23.250577]  __sk_free+0x51/0x160
[   23.250807]  sk_free+0x45/0x70
[   23.251025]  unix_release_sock+0x5cc/0x700
[   23.251301]  unix_release+0x50/0x70
[   23.251536]  __sock_release+0x5f/0x120
[   23.251754]  sock_close+0x13/0x20
[   23.252109]  __fput+0x1f3/0x470
[   23.252451]  __fput_sync+0x2f/0x40
[   23.252811]  __x64_sys_close+0x51/0x90
[   23.253169]  do_syscall_64+0x38/0x90
[   23.253480]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   23.253940]
[   23.254097] The buggy address belongs to the object at ffff8881013f9800
[   23.254097]  which belongs to the cache UNIX-STREAM of size 1920
[   23.254936] The buggy address is located 96 bytes inside of
[   23.254936]  freed 1920-byte region [ffff8881013f9800, ffff8881013f9f80)
[   23.255731]
[   23.255844] The buggy address belongs to the physical page:
[   23.256225] page:00000000c005ecb3 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881013f8000 pfn:0x1013f8
[   23.256905] head:00000000c005ecb3 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   23.257382] flags: 0x2fffe000000840(slab|head|node=0|zone=2|lastcpupid=0x7fff)
[   23.257791] page_type: 0xffffffff()
[   23.257988] raw: 002fffe000000840 ffff888100961a40 dead000000000122 0000000000000000
[   23.258418] raw: ffff8881013f8000 000000008010000e 00000001ffffffff 0000000000000000
[   23.258817] page dumped because: kasan: bad access detected
[   23.259131]
[   23.259205] Memory state around the buggy address:
[   23.259469]  ffff8881013f9700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.259871]  ffff8881013f9780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.260290] >ffff8881013f9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.260704]                                                        ^
[   23.261056]  ffff8881013f9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.261469]  ffff8881013f9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.261854] ==================================================================
[   23.262453] Disabling lock debugging due to kernel taint
#212/79  sockmap_listen/sockmap VSOCK test_vsock_redir:OK
#212     sockmap_listen:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
bash-5.2#

If I modify the test to use (AF_UNIX, SOCK_DGRAM) instead of
SOCK_STREAM, the bug no longer reproduces.

Which confirms my thinking that unix_dgram_sendmsg is safe to use from
sockmap because it grabs a ref to skpair.

