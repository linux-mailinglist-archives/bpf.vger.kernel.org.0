Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128731689E0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBUWPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 17:15:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34306 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUWPg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 17:15:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so1698976pgi.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 14:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kXLJzM+fudX+dk2vxGD8qXAlS6NHJlq4l43rKFobmIY=;
        b=Gc7qTHn74XmNFUGT18DRPr/JsTZZEH/R8iCK7yOVNokNvtxMq24mQGS/A3UBa734Oe
         ok5JEGXxkAGI5niBWfu8iTF3dy3cbSvEQOUiHM5bk8+K/i1B54Ha/ZTIyDMIPNepANzS
         2JlhVJ9Y4Q5Jos3/06GoKWW6fEoxhqP/wI0ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXLJzM+fudX+dk2vxGD8qXAlS6NHJlq4l43rKFobmIY=;
        b=Xs5SqQvk3FGCLPBzxuTr9Z1Q0E9eOGfy+U22daajuoDHAB/RdC5KXZr9nNRkcfKn6A
         mPztvwakHl49qr31Iq8QzqSUkhyn6UkX1dkitvJYcpkyP1+2rCnL1TsZnJ69qKCbfqK+
         VtD51lOJKcHHqwxOWgtXBgQUq0YWfP7oTlR9gKGqN7OTP2iu9QAbsgpKV85uqMPYkJrt
         AvE7lU9tUygDuAVZBfIvQmgSlb+8y0dG0NXcA+HLUmdCEl0fFN54KxA7cmjfBYbSSQsi
         f7LlWkWU2YXLi9UE9YK2dVHMVy2g6xwUK3YMotKw0YGLex7BLyfM95rPAHmY7jCzjyJ/
         HPLw==
X-Gm-Message-State: APjAAAU4wcODXoYmXcdDrqKydX9bNhNDVdsYO+52wfRzx7kIXJO7BrMb
        EqJRxLWsi/bgGrn516x2dhwsmQ==
X-Google-Smtp-Source: APXvYqw/4KMFiZHKgqWkcx8RiqfqgaEMBsI7aB5y+dpe0h7yWzHYitbJTEbwREjD5aqSPClkV4sogw==
X-Received: by 2002:a62:36c2:: with SMTP id d185mr41244236pfa.203.1582323334247;
        Fri, 21 Feb 2020 14:15:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm3477608pgk.84.2020.02.21.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 14:15:33 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:15:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC patch 09/19] bpf: Use BPF_PROG_RUN_PIN_ON_CPU() at simple
 call sites.
Message-ID: <202002211415.4111F356A@keescook>
References: <20200214133917.304937432@linutronix.de>
 <20200214161503.804093748@linutronix.de>
 <87a75ftkwu.fsf@linux.intel.com>
 <875zg3q7cn.fsf@nanos.tec.linutronix.de>
 <202002201616.21FA55E@keescook>
 <87lfownip5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfownip5.fsf@nanos.tec.linutronix.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 21, 2020 at 03:00:54PM +0100, Thomas Gleixner wrote:
> Kees Cook <keescook@chromium.org> writes:
> > They're technically independent, but they are related to each
> > other. (i.e. order matters, process hierarchy matters, etc). There's no
> > reason I can see that we can't switch CPUs between running them, though.
> > (AIUI, nothing here would suddenly make these run in parallel, right?)
> 
> Of course not. If we'd run the same thread on multiple CPUs in parallel
> the ordering of your BPF programs would be the least of your worries.

Right, okay, good. I just wanted to be extra sure. :)

-- 
Kees Cook
