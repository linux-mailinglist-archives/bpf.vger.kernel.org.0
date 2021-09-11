Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84308407A76
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhIKVOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Sep 2021 17:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIKVOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Sep 2021 17:14:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37440C061574
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 14:13:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d18so3353541pll.11
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQYoFqAi5ik4tbMfLghNKTAjNiIYA7qEoxNw70ugRnk=;
        b=fQqtTvjfW6Uk6TP6THx9qVsF+7pvLtOCmKdZdoZ1Tt27SsxgZeLvTzyrSDB9EnO8qY
         LeBAFN/3DRw9NR3vK7IcHpY4SZRmh1C9OwRKKneRmG1wIii+fWP1Jnw5a7ty0GyLmIzD
         0DTvX+pyLazs8O7KNbw8Nf9rSQ7ytTxaUeT8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQYoFqAi5ik4tbMfLghNKTAjNiIYA7qEoxNw70ugRnk=;
        b=TT0wFPfp0HZnCtDC5iak7V5e17Jktq/SEqBNtqKPgtIVCJTZ5/jU+VfbDAhkPTK7x+
         7EvFGJZ646Z56KNe4jpLKsKe+LczoZJiRZHCMNs2Whma3ta0OsPxT3cnH4ooPcZeg5iD
         jeXcSkwgflLFJ5VEz2gK9aCg0Y3jr7xjh5BPZsvKF6y9k8gW+axlW6N+uJfNDLVBUe2e
         HnugEw8mpv8qlAUawTbG0t6KhWypbSjF3vuCZYCz9nOKDeGwv8mo+q8D3gNrdl4PTY9S
         FrC0BFM8el6xh3tkeL/kfb4iddaa2h+GD1tBpV/7iWCcDz53gMtPIG/QJ7l0H6RUb+/d
         QqRg==
X-Gm-Message-State: AOAM531X5vcubCkL1957FzgDtVSq2uyJJOV6ddNk1S/5vaJfKm05C2XX
        VGxEjtNqHwgg9qVRSMr/yZDzkw==
X-Google-Smtp-Source: ABdhPJw0i4ZOH3FiIvR3nlDfzLLv0nF5OYs1OW8BjpJQXrkxYMcmvo8MqIVe1Lg7l2HBwwdP7jxKFg==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr4765498pjg.75.1631394800769;
        Sat, 11 Sep 2021 14:13:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a21sm2489063pjo.14.2021.09.11.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 14:13:20 -0700 (PDT)
Date:   Sat, 11 Sep 2021 14:13:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
Message-ID: <202109111411.C3D58A18EC@keescook>
References: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
 <20201104235054.5678-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104235054.5678-1-aarcange@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
> Switch the kernel default of SSBD and STIBP to the ones with
> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.

Hello x86 maintainers!

I'd really like to get this landed, so I'll take this via the
seccomp-tree unless someone else speaks up. This keeps falling off
the edge of my TODO list. :)

-Kees

-- 
Kees Cook
