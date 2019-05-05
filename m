Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5514252
	for <lists+bpf@lfdr.de>; Sun,  5 May 2019 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEEUbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 May 2019 16:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEUbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 May 2019 16:31:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADEB20651;
        Sun,  5 May 2019 20:31:47 +0000 (UTC)
Date:   Sun, 5 May 2019 16:31:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?B?TWljaGHFgg==?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190505163145.45f77e44@oasis.local.home>
In-Reply-To: <20190505132623.GA3076@localhost>
References: <20190504121213.183203-1-joel@joelfernandes.org>
        <20190504122158.GA23535@kroah.com>
        <20190504123650.GA229151@google.com>
        <20190505091030.GA25646@kroah.com>
        <20190505132623.GA3076@localhost>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 5 May 2019 13:26:23 +0000
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> > On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:  
> > > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > > should have barfed on this change.  
> > > 
> > > fixed, below is the updated patch inline, thanks!  
> > 
> > Please resend as a "real" submission, doing so in this format is a bit
> > more difficult to apply.  
> 
> git am --scissors can do it, but no problem I will send as a formal
> submission. Thanks a lot.
>

True, but a lot of us depend on scripts to pull in patches from our
INBOX. Which is why we like them to stay with the standard format.

-- Steve
