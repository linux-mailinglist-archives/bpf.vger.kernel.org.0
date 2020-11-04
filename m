Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC62A704E
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgKDWOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDWOK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 17:14:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F5BC0613D3
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 14:14:10 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z3so12109838pfz.6
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4SX8JmQlcxK5oX4LLeWbxpL7OAoTDYcCU+6+RVvGYlM=;
        b=RX2JBijVQFv1L+Mod4nyguYVc83aMkdQnTSA4fshKUc7aV23uLUvF08QHDh0Is4Pqc
         Y8C7u7YARCq/nsAwL8gHMGWDjRZ/i8rf6teR9z+sDJZUgLYQtq2wJ0I48zHOVm1zkNrf
         ta1xYjO+dpWNT4NcIGfE2jZIbJ6ZSCtbIauIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SX8JmQlcxK5oX4LLeWbxpL7OAoTDYcCU+6+RVvGYlM=;
        b=eR58sdE4kXTH7Z5jYwU4iFuqGA/XpJ+izrs+wMwJ8i5BpPxhqBP3UBL4ttLpCL2Zlh
         HJnXYMR+JBTQv0NtFz2e22cc4eIz4UW+shNwKZBK9RaZIhCWlpMEz4UjzIHG0ntKHX+3
         OO2TiktIvgN0Lzk2imEaB/wAep3l/0TiCPEhc3DQX63GvOW5fO3oZU6gIjYxBNF81Ne2
         Cm0CR9diapR9T2t6DVkA2NzVoVOxehCINWWe13R1xvByNZgMk0Q4b3ec4Y3hP+7IAEfv
         15HqhjUTGxSAq/6wtTQzaXu97ZrUh6NoTXkeS8qqxDho4MoNVQrUfb3T8zHChzqdRV8I
         VvAA==
X-Gm-Message-State: AOAM533QygvFIDzsCBmP+8pvLqAKkm7PWuCuolwBO9A1dd3/TsqQYXOa
        c2cSmZIpKuY6/K68eZ29YYonZw==
X-Google-Smtp-Source: ABdhPJwnQvdrXkvZA4YnhjXoMmBDm+dt32SsDETknXAd989qVmGT8ZvBz6SW/KD78kJNz8WtONYvwA==
X-Received: by 2002:a17:90b:b12:: with SMTP id bf18mr11114pjb.205.1604528049604;
        Wed, 04 Nov 2020 14:14:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm3306738pgh.15.2020.11.04.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:14:08 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:14:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: Re: RFC: default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl
Message-ID: <202011041411.AD961737EA@keescook>
References: <20201104215702.GG24993@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104215702.GG24993@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 04:57:02PM -0500, Andrea Arcangeli wrote:
> Switch the kernel default of SSBD and STIBP to the ones with
> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.

Agreed. I think this is the right time to flip this switch. I agree with
the (very well described) rationales. :)

Fundamentally, likely everyone who is interested in manipulating the
mitigations are doing so now, and it doesn't make sense (on many fronts)
to tie some to seccomp mode any more (which was intended as a temporary
defense to gain coverage while sysadmins absorbed what the best
practices should be).

Thanks for sending this!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
