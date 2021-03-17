Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC51333E862
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 05:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhCQEVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 00:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhCQEVU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 00:21:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420FFC06174A
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 21:21:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so399002pjq.1
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wa3Q/hAfr4KEnIDsGDRK0UqwGF9Hp9PJ29GVgEZpy6s=;
        b=Pul2BHsG1IgVRFP5/0iXxb9S0qZSu47o9zZMkxgqRYdPaSsaomkcIaSXSlgnt2RaSS
         BAa4shFPDWI1A0C0DA/3sn3MqlLmskwYKn5d5H1qyuQFniv/QkSGgnZPjm0isqUpoOfI
         Wa8r25sBiTfhd4CxUhDfN4EtGeOHVkCY/aQlgDYQF5YTkkvLawiIfUAtG6IvIFQ2UFSl
         RNRrjBP+5zfY0pz8EZnYZAYabe/QDRLkX2nSXDyfvT4UbmoJ0QrnL3Bn/RTTyA9cNX0p
         1WkAwhiAhLx0Fa2xSEkvKLgqXZGvwGSZ58EuQXpzTU/dtARboVOFmkG7e5eZWaXWNmFc
         UwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wa3Q/hAfr4KEnIDsGDRK0UqwGF9Hp9PJ29GVgEZpy6s=;
        b=ALkauvZHQ7vOpAD0hIAexPlx5ocuAahayV7ymmSsZmHzFogwXLs08vE5Ub19DPfcm2
         Ct7PeqURLAFqjps6tBlRCBuxy6Asw9+Ey/Rxz9ltO094duRg/8OY66TH5v8Aj48R8TW6
         XOS/CfxZk7VekrmB2EoaBZ8QApY+HnQRa3RsaUIuMO8g0skF/tac9+oJtKmqzNsxWils
         vhrQMiSbakPQDlHCsZq+ema5JODQgW1MpR9iHjAqg/aGlJbiF3/+2BfDUckAPyIP6jko
         F3wohpJgxBQ2TCWPj6izxHl3VISSxz91ahEL2LIdI31qIRgOsEwFgH9h4LFF77+oWbW9
         evDg==
X-Gm-Message-State: AOAM530zalik+nzwNDe9k9ZNbNvgPmm4lwqRIC0DZePLm1YdZC2brJYK
        FsOaYYNgpWZTf6RIQxww+++DdGeulvpPnBENxIU=
X-Google-Smtp-Source: ABdhPJxQqAuQp/EAXkpAUZm86vgvMoyy+1+iTRY02N8Xh7Xzc9G+xIDLiHb0eSfff82XY0kUUBfh+8n8xXjDJL5DCzM=
X-Received: by 2002:a17:90a:9f8c:: with SMTP id o12mr2373716pjp.215.1615954879853;
 Tue, 16 Mar 2021 21:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
 <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com> <CAM_iQpXP-m03auwF_Ote=oSev3ZVmJ5Pj_5-8aJOTMz+Nmhhgw@mail.gmail.com>
In-Reply-To: <CAM_iQpXP-m03auwF_Ote=oSev3ZVmJ5Pj_5-8aJOTMz+Nmhhgw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Mar 2021 21:21:08 -0700
Message-ID: <CAM_iQpUvU3PQ9-i1n+YW7GU_FNSzURe1v61AkJw=QutxEZhakw@mail.gmail.com>
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

On Sat, Mar 13, 2021 at 11:19 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Please let me know what you think about introducing a timer
> map, something like below:
>
> struct {
>      __uint(type, BPF_MAP_TYPE_TIMER);
> } map SEC(".maps");
>
> struct bpf_timer t;

After some thoughts, I think the following solution is much better.

We still need a timer map:

struct {
     __uint(type, BPF_MAP_TYPE_TIMER);
} map SEC(".maps");

However, its key is not a pointer to timer, it is a timer ID allocated with

u32 bpf_timer_create(void *callback, void *arg, u64 flags);

which returns a globally unique ID. So, we end up having code like
this:

u32 timer_id;

static int timer_cb(void *arg)
{
  // show how to rearm a timer
  u64 new_expires = ...;
  bpf_map_update_elem(&map, &timer_id, &new_expires, 0);
}

int bpf_timer_test(...)
{
  u64 expires = ...;

  timer_id = bpf_timer_create(timer_cb, arg, 0);
  bpf_map_update_elem(&map, &timer_id, &expires, 0);

  // wait for timer deletion synchronously
  bpf_map_delete_elem(&map, &timer_id);
}

In kernel, we can use an IDR to allocate these ID's and save a kernel
timer pointer for each ID there.

With this solution, we don't need to change much in the verifier,
probably only verifying the callback arg pointer for bpf_timer_create().

Any thoughts on this proposal?

Thanks!
