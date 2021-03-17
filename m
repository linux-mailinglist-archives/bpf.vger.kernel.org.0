Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B432933F6BC
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCQR0i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCQR02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 13:26:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF96C06174A
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 10:26:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x29so11253pgk.6
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRiQsQ6pUg2QCbWA5SCXQRVHFpfpp11ZqT5ulDn3OSE=;
        b=BDs1CFsP16UpWuUQmn6Z7omU17z/mkVePMLETg7ZH+WWuDEgThO+cJZDOn6sw+3E3W
         i24+Y7VqrHumPGzq96Gcsu5MCZagNB9nfrvTvNq7mBkacvTuKpv8kK5UZEEc9LWUWRAo
         Mp4F3DpuWZzzhpg8bDF8to32GaOviPhNiL6YulCqobZbKJyMvJ2iJUO/f5XNAgA42L61
         OH1Z8ZCoKiEcva02RAgvduop98TmOV9jSD5X9hJCi7xWf5F4RrNWu9Chj45zPrV8RlZB
         v9W/cr6WiDeCD2s0c+9/Fm7jM94n4x4Sktw0DF+sYUtOS6La2kLPFVY7jeXxzdDF9Q5N
         uTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRiQsQ6pUg2QCbWA5SCXQRVHFpfpp11ZqT5ulDn3OSE=;
        b=qLOsSsPE106cYw03XfultOuCHcMktAqCezp37ngsbs8dNoI/tUGRIyFRiLAqVPJJts
         jIj4RYfGITpv/gClOzpeqvDDkFiryxqyTIlf1bFLO8UtGGY7p5QwXC+xqbf1G9bditoj
         qBrjKBjpZiRkCBKfCJJNqgGSWez8f3kiLX4JX9SY7gzcJiW5hP7Ot8Qg2L+ll/W2D4o4
         JIVK/2Gd2hgkRK2NNrNPFeP2nLgGef0EcwC+59BXZ/YSGD6uDtlAKg5UIYzpf50itD9+
         EA/hWNhAmTggaYdlA2osPMv7WQKNxy16eHds7y7o1vE7yp16jSrAkQOvVS5/DSWoikZa
         o+CA==
X-Gm-Message-State: AOAM533sXpDOLcn+Jj0fLb6y+urT2lE5gtrN26V4ORZUa1kLyw9OGQd7
        khGnNkgane7oiWf22AT/ioZ2RCqZIYODJG8qmyM=
X-Google-Smtp-Source: ABdhPJzq2VcA4r0KrgdBQHh/tEaa3PaxMFB4xgY03Flq9TQvv49/5ti8m6+20eCgwLFCK9iHLcvZ9yqwH82fi5XKBNw=
X-Received: by 2002:a62:8485:0:b029:1fc:d912:67d6 with SMTP id
 k127-20020a6284850000b02901fcd91267d6mr90494pfd.80.1616001988115; Wed, 17 Mar
 2021 10:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
 <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com>
 <CAM_iQpXP-m03auwF_Ote=oSev3ZVmJ5Pj_5-8aJOTMz+Nmhhgw@mail.gmail.com> <CAM_iQpUvU3PQ9-i1n+YW7GU_FNSzURe1v61AkJw=QutxEZhakw@mail.gmail.com>
In-Reply-To: <CAM_iQpUvU3PQ9-i1n+YW7GU_FNSzURe1v61AkJw=QutxEZhakw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 17 Mar 2021 10:26:15 -0700
Message-ID: <CAM_iQpU+9e5op7ZEgX1ThSfBxqOemw6Dy_hZFaBR0mHk1XePSQ@mail.gmail.com>
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

On Tue, Mar 16, 2021 at 9:21 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> We still need a timer map:
>
> struct {
>      __uint(type, BPF_MAP_TYPE_TIMER);
> } map SEC(".maps");
>
> However, its key is not a pointer to timer, it is a timer ID allocated with
>
> u32 bpf_timer_create(void *callback, void *arg, u64 flags);

Hmm, we do not need a map at all, because the verifier could check
whether create() and delete() are paired correctly, so we can just
have the following API's:

u32 bpf_timer_create(void *callback, void *arg, u32 flags);
void bpf_timer_settime(u32 id, u64 expires);
u64 bpf_timer_gettime(u32 id);
int bpf_timer_delete(u32 id);

Pretty much similar to Linux user-space timer API's. I will probably
go this direction, unless there is any objection.

Thanks.
