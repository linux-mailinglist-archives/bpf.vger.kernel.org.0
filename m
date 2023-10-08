Return-Path: <bpf+bounces-11648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246D7BCBC4
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 04:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC4281A24
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31915DA;
	Sun,  8 Oct 2023 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F0188;
	Sun,  8 Oct 2023 02:46:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A62BA;
	Sat,  7 Oct 2023 19:46:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S363q2wrLz4f3jHs;
	Sun,  8 Oct 2023 10:45:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA3kVDoFyJlWGsRCQ--.44242S2;
	Sun, 08 Oct 2023 10:46:04 +0800 (CST)
Subject: Re: Possible kernel memory leak in bpf_timer
To: Hsin-Wei Hung <hsinweih@uci.edu>
References: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Message-ID: <8bf09dbd-670d-a666-8dcd-fc3406fa7ada@huaweicloud.com>
Date: Sun, 8 Oct 2023 10:46:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------15FD206F8C6B3786C1BC745E"
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA3kVDoFyJlWGsRCQ--.44242S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWftFWrWr47Cw4xKrWfXwb_yoW5Ww45pr
	W8Cw47CrW8Jr48Aw4Utr1kJry5tw1UC3WUJr1rJF1UZr1xWF1jgF17Wr4jgF45Jrs7Jr17
	Xw1vq34Fvw1UJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4xvF2IEb7IF0Fy26I8I
	3I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUFyxR
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------15FD206F8C6B3786C1BC745E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/27/2023 1:32 PM, Hsin-Wei Hung wrote:
> Hi,
>
> We found a potential memory leak in bpf_timer in v5.15.26 using a
> customized syzkaller for fuzzing bpf runtime. It can happen when
> an arraymap is being released. An entry that has been checked by
> bpf_timer_cancel_and_free() can again be initialized by bpf_timer_init().
> Since both paths are almost identical between v5.15 and net-next,
> I suspect this problem still exists. Below are kmemleak report and
> some additional printks I inserted.
>
> [ 1364.081694] array_map_free_timers map:0xffffc900005a9000
> [ 1364.081730] ____bpf_timer_init map:0xffffc900005a9000
> timer:0xffff888001ab4080
>
> *no bpf_timer_cancel_and_free that will kfree struct bpf_hrtimer*
> at 0xffff888001ab4080 is called

I think the kmemleak happened as follows:

bpf_timer_init()
  lock timer->lock
    read timer->timer as NULL
    read map->usercnt != 0

                bpf_map_put_uref()
                  // map->usercnt = 0
                  atomic_dec_and_test(map->usercnt)
                    array_map_free_timers()
                    // just return and lead to mem leak
                    find timer->timer is NULL

    t = bpf_map_kmalloc_node()
    timer->timer = t
  unlock timer->lock

Could you please try the attached patch to check whether the kmemleak
problem has been fixed ?

>
> [ 1383.907869] kmemleak: 1 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> BUG: memory leak
> unreferenced object 0xffff888001ab4080 (size 96):
>   comm "sshd", pid 279, jiffies 4295233126 (age 29.952s)
>   hex dump (first 32 bytes):
>     80 40 ab 01 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000009d018da0>] bpf_map_kmalloc_node+0x89/0x1a0
>     [<00000000ebcb33fc>] bpf_timer_init+0x177/0x320
>     [<00000000fb7e90bf>] 0xffffffffc02a0358
>     [<000000000c89ec4f>] __cgroup_bpf_run_filter_skb+0xcbf/0x1110
>     [<00000000fd663fc0>] ip_finish_output+0x13d/0x1f0
>     [<00000000acb3205c>] ip_output+0x19b/0x310
>     [<000000006b584375>] __ip_queue_xmit+0x182e/0x1ed0
>     [<00000000b921b07e>] __tcp_transmit_skb+0x2b65/0x37f0
>     [<0000000026104b23>] tcp_write_xmit+0xf19/0x6290
>     [<000000006dc71bc5>] __tcp_push_pending_frames+0xaf/0x390
>     [<00000000251b364a>] tcp_push+0x452/0x6d0
>     [<000000008522b7d3>] tcp_sendmsg_locked+0x2567/0x3030
>     [<0000000038c644d2>] tcp_sendmsg+0x30/0x50
>     [<000000009fe3413f>] inet_sendmsg+0xba/0x140
>     [<0000000034d78039>] sock_sendmsg+0x13d/0x190
>     [<00000000f55b8db6>] sock_write_iter+0x296/0x3d0
>
>
> Thanks,
> Hsin-Wei (Amery)
>
>
> .


--------------15FD206F8C6B3786C1BC745E
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Check-map-usercnt-again-after-timer-timer-is-ass.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-bpf-Check-map-usercnt-again-after-timer-timer-is-ass.pa";
 filename*1="tch"

RnJvbSAwODc1ZjBkZTc2ZTk4MGVjNWQ2N2JiNmFmMmNkZjgyNWQ0NTU5Yjk2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIb3UgVGFvIDxob3V0YW8xQGh1YXdlaS5jb20+CkRh
dGU6IFN1biwgOCBPY3QgMjAyMyAxMDozNjozNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGJw
ZjogQ2hlY2sgbWFwLT51c2VyY250IGFnYWluIGFmdGVyIHRpbWVyLT50aW1lciBpcyBhc3Np
Z25lZAoKU2lnbmVkLW9mZi1ieTogSG91IFRhbyA8aG91dGFvMUBodWF3ZWkuY29tPgotLS0K
IGtlcm5lbC9icGYvaGVscGVycy5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2hlbHBlcnMuYyBiL2tl
cm5lbC9icGYvaGVscGVycy5jCmluZGV4IDZmNjAwY2M5NWNjZC4uNzdkM2RlYjJlNTc2IDEw
MDY0NAotLS0gYS9rZXJuZWwvYnBmL2hlbHBlcnMuYworKysgYi9rZXJuZWwvYnBmL2hlbHBl
cnMuYwpAQCAtMTEzOCw4ICsxMTM4LDE3IEBAIEJQRl9DQUxMXzMoYnBmX3RpbWVyX2luaXQs
IHN0cnVjdCBicGZfdGltZXJfa2VybiAqLCB0aW1lciwgc3RydWN0IGJwZl9tYXAgKiwgbWFw
CiAJaHJ0aW1lcl9pbml0KCZ0LT50aW1lciwgY2xvY2tpZCwgSFJUSU1FUl9NT0RFX1JFTF9T
T0ZUKTsKIAl0LT50aW1lci5mdW5jdGlvbiA9IGJwZl90aW1lcl9jYjsKIAl0aW1lci0+dGlt
ZXIgPSB0OworCS8qIEd1YXJhbnRlZSB0aW1lci0+dGltZXIgaXMgdmlzaWJsZSB0byBicGZf
dGltZXJfY2FuY2VsX2FuZF9mcmVlKCkgKi8KKwlzbXBfbWJfX2JlZm9yZV9hdG9taWMoKTsK
KwlpZiAoIWF0b21pYzY0X3JlYWQoJm1hcC0+dXNlcmNudCkpIHsKKwkJdGltZXItPnRpbWVy
ID0gTlVMTDsKKwkJcmV0ID0gLUVQRVJNOworCQlnb3RvIG91dDsKKwl9CisJdCA9IE5VTEw7
CiBvdXQ6CiAJX19icGZfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGltZXItPmxvY2spOwor
CWtmcmVlKHQpOwogCXJldHVybiByZXQ7CiB9CiAKLS0gCjIuMjkuMgoK
--------------15FD206F8C6B3786C1BC745E--


