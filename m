Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24D1615B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2019 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGJrp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 May 2019 05:47:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39195 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfEGJro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 May 2019 05:47:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so6712540pgi.6
        for <bpf@vger.kernel.org>; Tue, 07 May 2019 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XAPkXFEJd/9+U7LZM5RTHwLX5SfNQT4uABRWDf3e59U=;
        b=wkcJ5IULORPol9Ta9jcdQPInjjpcxx2iGSzhbZ7uuBV7xoF7dl3Vy6MmlvysAw/Eqx
         dZv/7YvXxLRA4xMYaq5vMQvnjq+2pRGGpfpdknVG8mcV+b1I0zwMQo9hwKV/Z+xupRHC
         W0INIqcGPApsGsSO+eRNhJ/rPEw9aWUlmIZo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAPkXFEJd/9+U7LZM5RTHwLX5SfNQT4uABRWDf3e59U=;
        b=qLPiUCVvCZ621jPO3z8N/SQ+XZqr1l/VdDyfvbGMsF4F8HyzCh4gPdfBaTmJth5Ggt
         fw/V5rUvL6iWD5uUsDvMSgLU7PZ7xhiPYSuML9uQKv0XSLtcHDeF+tgv4Qtx2lF/qgr7
         VZvejdsDbnprlfT+/5P53Ymb6/8AdwWw99WdVV6M7JcEMvuM6GjuX5AMOm8z1oFewNHh
         Ad3BeRBqxII66UyyGoMcl6pKNEVukjcRr3BF1cS3847BCPTFFTLekmZm5RX/y6xCheaM
         6LgsL3qfdO5CbxM+yI1rDyGcs+Mnr4jJ+uTELXlul/AS9+1LDHb2vhAqTItxHpNLK4fI
         D1WA==
X-Gm-Message-State: APjAAAXosxlP1x2v7jbXKKRAQJIMVxunAA1rrHsy/avjG2eTCDqLDaIZ
        jkM5rgW9+SkVQ6TNxrKq2aq9ig==
X-Google-Smtp-Source: APXvYqxrmDTSHMsIWIJBNFG8bjwDyhOO5uL54BAU4eO3LAqCumsmrCHXMblrqJ9Xv+92YnI61//AtA==
X-Received: by 2002:a62:30c2:: with SMTP id w185mr40348063pfw.175.1557222463942;
        Tue, 07 May 2019 02:47:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j16sm15765973pfi.58.2019.05.07.02.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:47:42 -0700 (PDT)
Date:   Tue, 7 May 2019 05:47:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org,
        Michal Gregorczyk <michalgr@live.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Mohammad Husain <russoue@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        duyuchao <yuchao.du@unisoc.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2 1/4] bpf: Add support for reading user pointers
Message-ID: <20190507094741.GA6659@google.com>
References: <20190506183116.33014-1-joel@joelfernandes.org>
 <3c6b312c-5763-0d9c-7c2c-436ee41f9be1@iogearbox.net>
 <20190506195711.GA48323@google.com>
 <7e0d07af-79ad-5ff3-74ce-c12b0b9b78cd@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0d07af-79ad-5ff3-74ce-c12b0b9b78cd@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 07, 2019 at 01:10:45AM +0200, Daniel Borkmann wrote:
> On 05/06/2019 09:57 PM, Joel Fernandes wrote:
> > On Mon, May 06, 2019 at 09:11:19PM +0200, Daniel Borkmann wrote:
> >> On 05/06/2019 08:31 PM, Joel Fernandes (Google) wrote:
> >>> The eBPF based opensnoop tool fails to read the file path string passed
> >>> to the do_sys_open function. This is because it is a pointer to
> >>> userspace address and causes an -EFAULT when read with
> >>> probe_kernel_read. This is not an issue when running the tool on x86 but
> >>> is an issue on arm64. This patch adds a new bpf function call based
> >>> which calls the recently proposed probe_user_read function [1].
> >>> Using this function call from opensnoop fixes the issue on arm64.
> >>>
> >>> [1] https://lore.kernel.org/patchwork/patch/1051588/
> >>>
> >>> Cc: Michal Gregorczyk <michalgr@live.com>
> >>> Cc: Adrian Ratiu <adrian.ratiu@collabora.com>
> >>> Cc: Mohammad Husain <russoue@gmail.com>
> >>> Cc: Qais Yousef <qais.yousef@arm.com>
> >>> Cc: Srinivas Ramana <sramana@codeaurora.org>
> >>> Cc: duyuchao <yuchao.du@unisoc.com>
> >>> Cc: Manjo Raja Rao <linux@manojrajarao.com>
> >>> Cc: Karim Yaghmour <karim.yaghmour@opersys.com>
> >>> Cc: Tamir Carmeli <carmeli.tamir@gmail.com>
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> >>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >>> Cc: Peter Ziljstra <peterz@infradead.org>
> >>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> Cc: Steven Rostedt <rostedt@goodmis.org>
> >>> Cc: Kees Cook <keescook@chromium.org>
> >>> Cc: kernel-team@android.com
> >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>> ---
> >>> Masami, could you carry these patches in the series where are you add
> >>> probe_user_read function?
> >>>
> >>> Previous submissions is here:
> >>> https://lore.kernel.org/patchwork/patch/1069552/
> >>> v1->v2: split tools uapi sync into separate commit, added deprecation
> >>> warning for old bpf_probe_read function.
> >>
> >> Please properly submit this series to bpf tree once the base
> >> infrastructure from Masami is upstream.
> > 
> > Could you clarify what do you mean by "properly submit this series to bpf
> > tree" mean? bpf@vger.kernel.org is CC'd.
> 
> Yeah, send the BPF series to bpf@vger.kernel.org once Masami's patches have
> hit mainline, and we'll then route yours as fixes the usual path through
> bpf tree.

Sounds great to me, thanks!

 - Joel
