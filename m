Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA616802
	for <lists+bpf@lfdr.de>; Tue,  7 May 2019 18:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEGQi2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 May 2019 12:38:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41237 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfEGQi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 May 2019 12:38:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so8451147pls.8
        for <bpf@vger.kernel.org>; Tue, 07 May 2019 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PrwTuftts3y9+ku/n7DxYc7b66mYzqmoAIBNsj3WhKY=;
        b=eYuS+l8gX0WHf8bL+hHAPFqQfZhQoR7iHHmMsTJF/AZoxWrP2uPc9hHL65RynHjA5y
         Ab+bBINOze/EvQMgc+TwH643On5R7KzTcdmED9ud1JFWFO6UK5TocFWfLLIJFhMZ2MUX
         7Uxj6u2ycKnfhohWj9D/bkHO7Kzvj7lwGqVUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrwTuftts3y9+ku/n7DxYc7b66mYzqmoAIBNsj3WhKY=;
        b=RUuTkYbS8DKcCHT3FQuerEplGCFwv5xphNmbbjhQ+D3vRkrZw9XIP/LS3ilQ3AB9nR
         4xJSNl7B/Zk4w0YddugIMFigT/TLGWSbnBgfrDbSEaTlM/NuIKMbItrL8x8BZpegKUEV
         vzio+xgButdimailTe2q+4HZeetv3AX7nJXPsHC9pubM86NwHkaXiZlxjEhmwAmPBkFD
         DoLiooS49wZNfcA10Xh0niXOQC72ryM3BOeBN3PwMk5t4LdXZum7yy581Hj64Es+LKw9
         rtwLykIEzgq6kL5uqv54xwZblrlWbMVAS7ID58S4NGvsaWedgfbpxd6anvMAIjRppCpz
         OpWA==
X-Gm-Message-State: APjAAAXWYiyV6q38uq27Ptcvoj0FZpXWpNMu0kJF+kK5b1HCPWzy0rkN
        2BfQD+Ls/wP1eX25AnxpgARKQw==
X-Google-Smtp-Source: APXvYqyXNcsoYomIv94eB9GdJoQ72JRx4fHgYfkhkqw5RgY/K0k80ijGbucCDJQPhA+hQTsNJZh9vw==
X-Received: by 2002:a17:902:2847:: with SMTP id e65mr3264147plb.319.1557247107171;
        Tue, 07 May 2019 09:38:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r8sm18061722pfn.11.2019.05.07.09.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:38:25 -0700 (PDT)
Date:   Tue, 7 May 2019 12:38:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190507163824.GC89248@google.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
 <20190505132623.GA3076@localhost>
 <20190505163145.45f77e44@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505163145.45f77e44@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 05, 2019 at 04:31:45PM -0400, Steven Rostedt wrote:
> On Sun, 5 May 2019 13:26:23 +0000
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> > > On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:  
> > > > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > > > should have barfed on this change.  
> > > > 
> > > > fixed, below is the updated patch inline, thanks!  
> > > 
> > > Please resend as a "real" submission, doing so in this format is a bit
> > > more difficult to apply.  
> > 
> > git am --scissors can do it, but no problem I will send as a formal
> > submission. Thanks a lot.
> >
> 
> True, but a lot of us depend on scripts to pull in patches from our
> INBOX. Which is why we like them to stay with the standard format.

Thanks makes sense. So Greg, I submitted this properly, does it look good to
you now? Steven, I would appreciate any Acks/Reviews on the patch as well:
https://lore.kernel.org/patchwork/patch/1070199/

- Joel
