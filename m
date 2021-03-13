Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AC33A04B
	for <lists+bpf@lfdr.de>; Sat, 13 Mar 2021 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhCMTTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Mar 2021 14:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhCMTTV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Mar 2021 14:19:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA3C061574
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 11:19:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gb6so6787423pjb.0
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpM+JmTazg9ZBhyhy5nJRSKR51C2TEIS3ypGmiIDHTU=;
        b=W1WqNOfJBiyg/qQxF9YsJOJESDfK5h0FRWBsBINYjl7nE8m962Sy1ZhzgDBHYA+ydn
         2WKRyGqIhB2vjP4q4AZqVdIHp8qBgH0S3PL7EEuRGziY70ReFWe7nPy8uPAIExlBxTui
         SUpbG2y9zrLFcmC+lrXzRy1iymms6XGQRsDJh/zr3rLwZjg4Sb5I0h8w4F95XjI/8p2P
         S6msLZYhpsLLcTxGsoGc0ZV6JTm7r794Fh7uTFfJmL6oCmLnfADvzOSvQjFEflS4j/Dj
         /zOazLyEQNZfEmikhMEOh3c5N52IKZPR8pLKn1Hx8cInkq1ceW2Xbr5YiyXOkHQ3qCiQ
         BadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpM+JmTazg9ZBhyhy5nJRSKR51C2TEIS3ypGmiIDHTU=;
        b=iQmEWFYJfhvoIPsjYfKIVl+CduWo/RmNKLUTQ28/jkf3f+hvU2reeTsWMESZBjr2T/
         /RhYzrFLw8sE3pWPyuCl7sK5CqAuXMvtmxHsWcUW7vD6BMEmnyAqpxMGo0vIl9lGrW41
         qaxu9q/HDc3K6KTm612LVbNv1FAJ4jHYyi+rrla8blJRPwFHKMmDmEwU5JoX6kZ1Pm+D
         xjgM+Fe4gb7DU1CXxSdkykOgjil79QIhM4B/xC0p/TdEzRpWuZT/AmYlveF+g46KMeAY
         +tVw+IASfWbMGy2kPAab9515+g9RPBcqPASgVeTEuGpIkPt79rh5NlkF8kvasNIhCplH
         LZhA==
X-Gm-Message-State: AOAM530ZpkJk+QS6cYYRE6NHQqKvjFaxOQITE/Mufm2nmV8CerK5TB50
        y1cpVBV8/n0vGI+LPvY1K112gIVrqK/TiMZagVk=
X-Google-Smtp-Source: ABdhPJxJHVumZBG+a+yY6ovLASuqnh+aUnHK8zkwjc+iamPNfaV0fukmBn2EcXKmnAHYZRbCg18+XCUVSQpiFjmlWi4=
X-Received: by 2002:a17:90a:8b16:: with SMTP id y22mr4786432pjn.191.1615663160940;
 Sat, 13 Mar 2021 11:19:20 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
 <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 13 Mar 2021 11:19:09 -0800
Message-ID: <CAM_iQpXP-m03auwF_Ote=oSev3ZVmJ5Pj_5-8aJOTMz+Nmhhgw@mail.gmail.com>
Subject: Re: bpf timer design
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        duanxiongchun@bytedance.com, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 9, 2021 at 5:19 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 08, 2021 at 04:11:40PM -0800, Cong Wang wrote:
> > Hi, all
> >
> > I have been thinking about eBPF timer APIs, it looks harder than I thought.
> >
> > The API's themselves are not hard, here is what I have:
> >
> > int bpf_timer_setup(struct bpf_timer *timer, void *callback_fn,
> >                     void *callback_ctx, u64 flags);
> > int bpf_timer_mod(struct bpf_timer *timer, u64 expires);
> > int bpf_timer_del(struct bpf_timer *timer);
> >
> > which is pretty much similar to the current kernel timer API's.
> >
> > The struct bpf_timer is a bit tricky, we still have to save the kernel timer
> > there but we do not want eBPF programs to touch it. So I simply save a pointer
> > to kernel timer inside:
> >
> > struct bpf_timer {
> >        void *ptr;
> > };
> >
> > but we obviously have to prevent eBPF programs from dereferencing it
> > with the verifier.
> >
> > The hardest part is on the verifier side, we have to check:
> >
> > 1. Whether a timer is initialized before use. For example:
> >
> > struct bpf_timer t;
> > bpf_timer_mod(&t, bpf_jiffies64() + HZ);
>
> relatively easy. see below.
>
> > 2. Whether a timer is still active before exiting. For example:
>
> also easy to do, but "must do bpf_timer_del before exiting" restriction
> is probably too limiting to be usable.

Well, if the timer callback uses, for example, a pointer to a variable
on stack, then I am afraid we have to delete it before returning.


>
> > struct bpf_timer t;
> > bpf_setup_timer(&t, ....);
> > bpf_timer_mod(&t, bpf_jiffies64() + HZ);
> > //end of the eBPF program
> >
> > I do not see any existing mechanism for checks like these, so potentially need
> > a lot of work.
>
> There are two ways to handle the ordering constraints:
> - bpf_spin_lock style which is simple.

This is the first I looked at, unfortunately bpf spinlock is too limited,
it does not even allow nesting, but for timer, "nesting" should be fine:

bpf_timer_setup(&t1...);
bpf_timer_setup(&t2...);
bpf_timer_mod(&t1...);
bpf_timer_mod(&t2...);
bpf_timer_del(&t1...);
bpf_timer_del(&t2...);


> - may_be_acquire_function/is_release_function which is more advanced.
> but the ordering issue is a small one comparing to the issue of life time of
> the struct bpf_timer.

Yeah, this is what I have been looking at. The major difference is we
should be able to init a timer without even using it:

bpf_timer_setup(&t...);
//end of program

With acquire/release syntax, they have to be paired.

> I'm assuming that it will be related one to one with struct timer_list.

Yes, this is what I meant by saving a pointer to struct timer_list
inside struct bpf_timer.

> Ideally the api would be similar to kernel and struct bpf_spin_lock
> demonstrated how it can be done. Unlike bpf_spin_lock which is
> always unlocked by the time program ends the bpf_timer will be still
> enqueued in the timer wheel when prog exits. So its life time should
> be separate from the program execution life time.

Right, I am sure we can take a refcnt to the program itself, however
it looks really weird if we still let timer run after the program exits,
because the timer could run infinitely by arming itself in the callback.


> The only bpf concept with such properties is a bpf map.
> Therefore one the ways would be to do each timer as a map element.
> Both array of timers and hash of timers would be needed.
> The map_lookup_elem would return a pointer to opaque struct bpf_timer.
> And then bpf_timer_init/mod/del can operate on that pointer.
> The verifier can be taught to check that timer_init() is called
> before timer_mod(), but it's simple enough to do in run-time.
> The timer_mod() operation is expensive. Few run-time checks
> will be negligible. For example bpf_time_mod() can check that
> 'function' pointer was not-NULL. Otherwise run-time EINVAL.
> Since struct bpf_timer is in a map, it's either zero-inited
> at element creation time or bpf_timer_init() was called on it.

Interestingly, we discussed this solution at Bytedance before, our
conclusion is using a map is not as flexible as making it independent.


> The bpf_spin_lock has a limitation that it can only be one per map
> element which allowed to simplify the verifier code a lot.
> I'm suggesting to use the same restriction for bpf_timer.

This limit is fine, at least for timeout hashmap, but the limitation of
nesting mentioned above is not.

> Implementation wise I hope it won't be as hard coded as process_spin_lock().
> High level I'm proposing 'struct bpf_timer { u64 opaque; }'
> as part of uapi/bpf.h.
> The bpf program can place it inside normal array/hash maps.
> The 'opaque' field will contain a pointer to dynamically allocated
> 'struct timer_list'.
> The prog would do:
> struct map_elem {
>     int stuff;
>     struct bpf_timer timer;
> };
>
> struct {
>     __uint(type, BPF_MAP_TYPE_HASH);
>     __uint(max_entries, 1);
>     __type(key, int);
>     __type(value, struct map_elem);
> } hmap SEC(".maps");
>
> static int timer_cb(struct map_elem *elem)
> {
>     if (whatever && elem->stuff)
>         bpf_timer_mod(&elem->timer, new_expire);
> }
>
> int bpf_timer_test(...)
> {
>     struct map_elem *val;
>
>     val = bpf_map_lookup_elem(&hmap, &key);
>     if (val) {
>         bpf_timer_init(&val->timer, timer_cb, flags);
>         val->stuff = 123;
>         bpf_timer_mod(&val->timer, expires);
>     }
> }

I see, it looks like you use a map to limit the lifetime of the timers.
Our internal discussion actually went further, we wanted to introduce
a special type of map just for timers, for example, key could be callback,
value could be expires.

>
> The map and prog destruction process would need to do del_timer()
> on all map elements that have embedded struct bpf_timer before
> freeing prog and map. Currently we don't have such constraint
> with bpf_spin_lock, but it shouldn't be hard to add.
> Similarly bpf_map_delete_elem() would need to do del_timer too.
> bpf_map_update_elem can skip touching part of the value
> that has struct bpf_timer. Again similar to bpf_spin_lock.
> See copy_map_value.

If we have a timer map, all of these can be hidden under the map
ops.

> Too really simplify the implementation we can restrict that
> either bpf_spin_lock or bpf_timer can be inside the element.
> (not both at the same time).
>
> Of course there are other ways to design bpf_timer api.
> I think the main advantage of connecting bpf_timer with
> a map element is the control of timer life time and
> additional data that timer_cb() will receive.
> The 'void *callback_ctx' in the beginning of your email has the same
> life time issue. It's difficult to make it part of bpf_timer_init().
> Instead bpf prog can store additional data into map element.
> It's not as flexible as bpf_for_each_map_elem that can
> take a pointer to stack, but with timers it's not trivial
> to guarantee that the stack is valid at the time callback is fired.
> I think it should be flexible enough timer api.

Agreed. If we enforce a map here, users would not be able to
use a standalone timer, but I think this is okay, we have to
make a trade-off anyway.

Please let me know what you think about introducing a timer
map, something like below:

struct {
     __uint(type, BPF_MAP_TYPE_TIMER);
} map SEC(".maps");

struct bpf_timer t;

static int timer_cb(void *arg)
{
  // show how to rearm a timer
  u64 new_expires = ...;
  bpf_map_update_elem(&map, &t, &new_expires, 0);
}

int bpf_timer_test(...)
{
  u64 expires;

  bpf_timer_init(&t, timer_cb, arg);

  // bpf_map_update_elem() rejects it if uninitialized
  bpf_map_update_elem(&map, &t, &expires, 0);

  // wait for timer deletion synchronously
  bpf_map_delete_elem(&map, &t);
}


Thanks a lot!
