Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3664337EF4A
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbhELXEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442257AbhELV5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:57:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F5C061763;
        Wed, 12 May 2021 14:56:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so19700337pfc.12;
        Wed, 12 May 2021 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hBIs9zoBCXixFNxxI1Y+QgjxyyGXOI7pXer0FPPUGm0=;
        b=h89iCqDDuXOH0Vk/EDXInZ940Xzs4Le9rckXb8+3vJOmj6dTacxaNPcSLCegTrOdPY
         n/RRF55MyoEnnk4FE2zPC3Vgvy5Vu81rSVKuf+1SCruex/PQseABn2OyfW034Zb/divX
         a6XhRDaw3OAQ0UFEObBl1ZgXy6I40MTOh2snwYyxQ2U/xlM14eBI/3qPZu3Djt2+zTWU
         cN8LIg8YRa8g29WSkLKVk0u6z9CUP8pOE9/AaS9/kkzQW/RjlN2qquZFLUWAQSLvkAn2
         HYtEkb12kZhbIjOtBpQq3kaGeZjooaW+uYeFTnTLfzj/q/cMc+ic7sm2ETM+9aF8gfiG
         ABwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBIs9zoBCXixFNxxI1Y+QgjxyyGXOI7pXer0FPPUGm0=;
        b=JfYYil7vsI9V9h/dgYJSDch/rFj0njwoCzUyjvXRpxsgpLvuOvCUTbvK0o98kSLier
         XVjDaYs+IZKo18HCaUmIOpbI93n2jQ21ItRn1GpO1A9eNRBMLOseei80/xF+GaxsD3rG
         KMvIb6tZR3gWmGFR1KTutlLEN3biHOZmtKp5IGbtGNVoAClNqMlgDtUhe7t58a5biK/w
         FT2yMfPAxwYXlkLVxVn99SZkLHG1STu5x/bW1oBy2YMjNmr0OI8Fni4yexjfgpEj7IRI
         hXSVu7WCaxDeXMQJdHxRw/yOp46AhHk1XYeq25whjLI0wdpSxquawQT4GWp/Jb7IdQXB
         eeiw==
X-Gm-Message-State: AOAM533DfCFZ84FJQ83gvloZKAMXCZDmNlIE/CvqHn0SjthEBRJeKUOA
        GGIR7D/48VXfOHUQG/vGQPs=
X-Google-Smtp-Source: ABdhPJzzHHVxOgUL5O+vv5ub4DxlXrQ8ixk7FCr/isi0NgKkbD5mfmURGn7iMDGC1xGCebwLWPPt0w==
X-Received: by 2002:a05:6a00:7d4:b029:28e:2b3:58bf with SMTP id n20-20020a056a0007d4b029028e02b358bfmr36865687pfu.77.1620856579425;
        Wed, 12 May 2021 14:56:19 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:c6f4])
        by smtp.gmail.com with ESMTPSA id 15sm567382pjf.57.2021.05.12.14.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 14:56:18 -0700 (PDT)
Date:   Wed, 12 May 2021 14:56:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 12/12] seccomp-ebpf: support task
 storage from BPF-LSM, defaulting to group leader
Message-ID: <20210512215613.jtvvyu7mahfkztdf@ast-mbp.dhcp.thefacebook.com>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <db41ad3924d01374d08984d20ad6678f91b82cde.1620499942.git.yifeifz2@illinois.edu>
 <20210511015814.5sr37y4ogf5cr7c5@ast-mbp.dhcp.thefacebook.com>
 <CABqSeARf03BsdWJJO-w=Bb+goHB6nmBaErz8Qmpgden_Q4Txeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeARf03BsdWJJO-w=Bb+goHB6nmBaErz8Qmpgden_Q4Txeg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 12:44:46AM -0500, YiFei Zhu wrote:
> On Mon, May 10, 2021 at 8:58 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 10, 2021 at 12:22:49PM -0500, YiFei Zhu wrote:
> > > +
> > > +BPF_CALL_4(bpf_task_storage_get_default_leader, struct bpf_map *, map,
> > > +        struct task_struct *, task, void *, value, u64, flags)
> > > +{
> > > +     if (!task)
> > > +             task = current->group_leader;
> >
> > Did you actually need it to be group_leader or current is enough?
> > If so loading BTF is not necessary.
> 
> I think if task_storage were to be used to apply a policy onto a set
> of tasks, there are probably more use cases to perform the state
> transitions across an entire process than state transitions across a
> single thread. Though, since seccomp only applies to the process tree
> a lot of use cases of a per-process storage would be covered by a
> global datasec too.
> 
> > You could have exposed it bpf_get_current_task_btf() and passed its
> > return value into bpf_task_storage_get.
> >
> > On the other side loading BTF can be relaxed to unpriv,
> > but doing current->group_leader deref will make it priv only anyway.
> 
> Yeah, that deref is what I was concerned about. It seems that if I
> expose BTF structs to a prog type it gains the ability to deref it,
> and I definitely don't want unpriv reading task_structs. Though yeah
> we could potentially change the verifier to prohibit PTR_TO_BTF_ID
> deref and any pointer arithmetic on it...
> 
> How about, we expose bpf_get_current_task_btf to unpriv, prohibit
> unpriv deref and pointer arithmetic, and have NULL be
> current->group_leader? This way, unpriv has access to both per-thread
> and per-process.

NULL to mean current->group_leader is too specific and not extensible.
I'd rather add another bpf_get_current_task_btf-like helper that
returns parent or group_leader depending on flags.
For now I wouldn't even do that. As you said hashmap with key=pid will
work fine. task_local_storage is a performance optimization.
I'd focus on landing the key bits before optimizing.
