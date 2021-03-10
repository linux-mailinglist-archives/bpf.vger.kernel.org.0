Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98153332B3
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 02:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCJBTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 20:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCJBTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Mar 2021 20:19:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80DCC06174A
        for <bpf@vger.kernel.org>; Tue,  9 Mar 2021 17:19:08 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m6so10954641pfk.1
        for <bpf@vger.kernel.org>; Tue, 09 Mar 2021 17:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYXRCzx9CqPTDrB2kUiwRluM4OHXMfkuph0P88HUlbY=;
        b=vgvMn4w3M54Re6MbiV1NXD/tbo+HKFg6KKnpI003Ebr1Xvp5jjSj/aX6tmWNMKBOCm
         qwte7z5LMDnnH90vXI4rvR9ZKSdF1YsxIV8zL9dMA2I+j5P4hqQF3EhieZM8sjpYR9OI
         aUMrDAx33iq0g7zPyl5EVWKhI4rqq0h7Ft0RPvmsN31Ni6fx6Ux1tqlzTlp90QZJgLBe
         CMlQsI7/X8auXtOgmp9zXkRNRKmVzDctbyqYmPtpr0FaDr56mfCiOwoYvwrsMOxDE+w4
         Si3yj2CJvqesrnqeZWEsL1xVKtMbGrFehPz8AR2liTng3epk8puJ+glLUxp9EqPaRAyS
         ruZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYXRCzx9CqPTDrB2kUiwRluM4OHXMfkuph0P88HUlbY=;
        b=sdRh5Hdx+qrSTfFQM/ef+9o+ldpz91QeuIWv6YOaYZ5/7ZLh+VEbIlj5+SYyZyQ6/t
         9plYgrVJx4257InDD8bvgpuF/ad6nQ5McvOeeE9R72KTlluITaPhHI0LrOkwdT5GTzee
         gnJ/XLPQpR+qzNxcxsKimAQG2t0msraI5sbzTGSKNlXEJxfYIcpTqraY/KZH71EVcibY
         42ncLfV4hyPFwgYa2i6z4hZ/moco/KDfbHD5R6nkPt2RbTDCMzfRZfF8bxkPTNXXR7Kd
         LFV+yHf8vWD+ovN1NCgHC76K0CJSDcImOBpzkxL6MkbrqfY7EHXyPum4jGxqnNZ/2mn8
         vrPA==
X-Gm-Message-State: AOAM533fsbuIxkg/2FeOwhDebgwNIsorG7CI49Jq4ihHYwQ146oijsNd
        e/g3vCjHkCU+twfBDq8kDZ4=
X-Google-Smtp-Source: ABdhPJw4VC0WCEkaKUzMRlue7qwU4SY14d5PvC1qsiE6ghkdK0H/Re1V+E6ffsKQDm94hwCQnQYmlg==
X-Received: by 2002:a62:18ca:0:b029:1f8:86c9:2330 with SMTP id 193-20020a6218ca0000b02901f886c92330mr840335pfy.15.1615339148395;
        Tue, 09 Mar 2021 17:19:08 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:7f6])
        by smtp.gmail.com with ESMTPSA id j92sm4185809pja.29.2021.03.09.17.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:19:07 -0800 (PST)
Date:   Tue, 9 Mar 2021 17:19:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        duanxiongchun@bytedance.com, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: bpf timer design
Message-ID: <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com>
References: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 08, 2021 at 04:11:40PM -0800, Cong Wang wrote:
> Hi, all
> 
> I have been thinking about eBPF timer APIs, it looks harder than I thought.
> 
> The API's themselves are not hard, here is what I have:
> 
> int bpf_timer_setup(struct bpf_timer *timer, void *callback_fn,
>                     void *callback_ctx, u64 flags);
> int bpf_timer_mod(struct bpf_timer *timer, u64 expires);
> int bpf_timer_del(struct bpf_timer *timer);
> 
> which is pretty much similar to the current kernel timer API's.
> 
> The struct bpf_timer is a bit tricky, we still have to save the kernel timer
> there but we do not want eBPF programs to touch it. So I simply save a pointer
> to kernel timer inside:
> 
> struct bpf_timer {
>        void *ptr;
> };
> 
> but we obviously have to prevent eBPF programs from dereferencing it
> with the verifier.
> 
> The hardest part is on the verifier side, we have to check:
> 
> 1. Whether a timer is initialized before use. For example:
> 
> struct bpf_timer t;
> bpf_timer_mod(&t, bpf_jiffies64() + HZ);

relatively easy. see below.

> 2. Whether a timer is still active before exiting. For example:

also easy to do, but "must do bpf_timer_del before exiting" restriction
is probably too limiting to be usable.

> struct bpf_timer t;
> bpf_setup_timer(&t, ....);
> bpf_timer_mod(&t, bpf_jiffies64() + HZ);
> //end of the eBPF program
> 
> I do not see any existing mechanism for checks like these, so potentially need
> a lot of work.

There are two ways to handle the ordering constraints:
- bpf_spin_lock style which is simple.
- may_be_acquire_function/is_release_function which is more advanced.
but the ordering issue is a small one comparing to the issue of life time of
the struct bpf_timer.
I'm assuming that it will be related one to one with struct timer_list.
Ideally the api would be similar to kernel and struct bpf_spin_lock
demonstrated how it can be done. Unlike bpf_spin_lock which is
always unlocked by the time program ends the bpf_timer will be still
enqueued in the timer wheel when prog exits. So its life time should
be separate from the program execution life time.
The only bpf concept with such properties is a bpf map.
Therefore one the ways would be to do each timer as a map element.
Both array of timers and hash of timers would be needed.
The map_lookup_elem would return a pointer to opaque struct bpf_timer.
And then bpf_timer_init/mod/del can operate on that pointer.
The verifier can be taught to check that timer_init() is called
before timer_mod(), but it's simple enough to do in run-time.
The timer_mod() operation is expensive. Few run-time checks
will be negligible. For example bpf_time_mod() can check that
'function' pointer was not-NULL. Otherwise run-time EINVAL.
Since struct bpf_timer is in a map, it's either zero-inited
at element creation time or bpf_timer_init() was called on it.
The bpf_spin_lock has a limitation that it can only be one per map
element which allowed to simplify the verifier code a lot.
I'm suggesting to use the same restriction for bpf_timer.
Implementation wise I hope it won't be as hard coded as process_spin_lock().
High level I'm proposing 'struct bpf_timer { u64 opaque; }'
as part of uapi/bpf.h.
The bpf program can place it inside normal array/hash maps.
The 'opaque' field will contain a pointer to dynamically allocated
'struct timer_list'.
The prog would do:
struct map_elem {
    int stuff;
    struct bpf_timer timer;
};

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __uint(max_entries, 1);
    __type(key, int);
    __type(value, struct map_elem);
} hmap SEC(".maps");

static int timer_cb(struct map_elem *elem)
{
    if (whatever && elem->stuff)
        bpf_timer_mod(&elem->timer, new_expire);
}

int bpf_timer_test(...)
{
    struct map_elem *val;

    val = bpf_map_lookup_elem(&hmap, &key);
    if (val) {
        bpf_timer_init(&val->timer, timer_cb, flags);
        val->stuff = 123;
        bpf_timer_mod(&val->timer, expires);
    }
}

The map and prog destruction process would need to do del_timer()
on all map elements that have embedded struct bpf_timer before
freeing prog and map. Currently we don't have such constraint
with bpf_spin_lock, but it shouldn't be hard to add.
Similarly bpf_map_delete_elem() would need to do del_timer too.
bpf_map_update_elem can skip touching part of the value
that has struct bpf_timer. Again similar to bpf_spin_lock.
See copy_map_value.
Too really simplify the implementation we can restrict that
either bpf_spin_lock or bpf_timer can be inside the element.
(not both at the same time).

Of course there are other ways to design bpf_timer api.
I think the main advantage of connecting bpf_timer with
a map element is the control of timer life time and
additional data that timer_cb() will receive.
The 'void *callback_ctx' in the beginning of your email has the same
life time issue. It's difficult to make it part of bpf_timer_init().
Instead bpf prog can store additional data into map element.
It's not as flexible as bpf_for_each_map_elem that can
take a pointer to stack, but with timers it's not trivial
to guarantee that the stack is valid at the time callback is fired.
I think it should be flexible enough timer api.
