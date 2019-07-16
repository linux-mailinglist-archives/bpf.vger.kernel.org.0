Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3533C6B1F4
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2019 00:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfGPWly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jul 2019 18:41:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPWly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jul 2019 18:41:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id g15so10145504pgi.4
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2019 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGWXFIfIr7/IFH288mFlt26MHGG0aBhmbsLutWSVGes=;
        b=EcohRi1mZ4EKL6fwSiAwLWMcin7sZI+MIk6GCtiDhRSMgWytraFqoXaoMFt+sbbrmE
         oHi2Lcvn9GOyVANvC0LB1lm5QZolkzZfux4aeLYce0/r0oOt5wzbHM50iaMO6QGv+zkS
         XrbhX93qjQC/C2ig8+xzL9NrBodFi1QjO+wxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGWXFIfIr7/IFH288mFlt26MHGG0aBhmbsLutWSVGes=;
        b=fN5ssMKHPHDtVuzdPXCWnhfcFNmgilQKsGrIW4hS3MIhE61OjGSMcPyOBd0ZcCAuqo
         Nd5ywiAq1/Pt1IgPiXs9gB9fMNXy0/60rL8kxSowPjQ493yz4gzN0rLk2e3I8B3TfMs4
         e/dff3RoBCc7K1JTU0OBPczUD5xv8SPeNcKKp0pjntjQIr/kXAG+piFmSdglfZBQAg/i
         gC+Fqr0Xuhw1eUgpArPnGq4BRCrsq2EI4M1waQzHq+xcTyBIJOzf7k8lNOGXEd54+fSm
         1dUnWahYr7ICo066raln/xcwNmeSXMaFUt8O6jJ9+5rwLSv1MPMJscm6KcMPhR11cHZK
         ViXA==
X-Gm-Message-State: APjAAAUM1YPIkUxjbT8W9H3lDh5UpAtuVX4DRXO6asO0tjU7k9GFLI5V
        fr4y3OPq4bl231OIxnsU2OI=
X-Google-Smtp-Source: APXvYqzcNNkpVR9OaPGYAXeKbbnGq3wrAudoy6HeZtUyNn20UB68UolNI9+loJGUKXR9bk/jgaWPig==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr3698792pgk.209.1563316913467;
        Tue, 16 Jul 2019 15:41:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x14sm24967454pfq.158.2019.07.16.15.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:41:52 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:41:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>, connoro@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        duyuchao <yuchao.du@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        jeffv@google.com, Karim Yaghmour <karim.yaghmour@opersys.com>,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        Manali Shukla <manalishukla14@gmail.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matt Mullins <mmullins@fb.com>,
        Michal Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>, namhyung@google.com,
        namhyung@kernel.org, netdev@vger.kernel.org,
        paul.chaignon@gmail.com, primiano@google.com,
        Qais Yousef <qais.yousef@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 0/4] Add support to directly attach BPF program to
 ftrace
Message-ID: <20190716224150.GC172157@google.com>
References: <20190710141548.132193-1-joel@joelfernandes.org>
 <20190716205455.iimn3pqpvsc3k4ry@ast-mbp.dhcp.thefacebook.com>
 <20190716213050.GA161922@google.com>
 <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 16, 2019 at 03:26:52PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 16, 2019 at 05:30:50PM -0400, Joel Fernandes wrote:
> > 
> > I also thought about the pinning idea before, but we also want to add support
> > for not just raw tracepoints, but also regular tracepoints (events if you
> > will). I am hesitant to add a new BPF API just for creating regular
> > tracepoints and then pinning those as well.
> 
> and they should be done through the pinning as well.

Hmm ok, I will give it some more thought.

> > I don't see why a new bpf node for a trace event is a bad idea, really.
> 
> See the patches for kprobe/uprobe FD-based api and the reasons behind it.
> tldr: text is racy, doesn't scale, poor security, etc.

Is it possible to use perf without CAP_SYS_ADMIN and control security at the
per-event level? We are selective about who can access which event, using
selinux. That's how our ftrace-based tracers work. Its fine grained per-event
control. That's where I was going with the tracefs approach since we get that
granularity using the file system.

Thanks.

