Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF81DB662A
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2019 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfIROcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 10:32:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40045 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbfIROck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Sep 2019 10:32:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so4230376pgj.7;
        Wed, 18 Sep 2019 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkYCmzxFtZ+pNCP1urZOYVz3GVAlckblbbr0pEk0OxU=;
        b=bhyly7evHYK8D39RoerQ8i88epE+rmfGrFFX4DRBzpghw/Jb+hj84/eQpNYESzVBtN
         o6IdpmFaDGUiwlEwnY2dG+bD7PtM/PqCoaW7FagwKDUrWy11Q0LhV8RzEugwnuqoiZhU
         vcUNo+Lx/N6L8gCm5NPY3wM3X2Z/3FDtkCgnqSTmBk/NMEgYNzy7nNi8MFHVOMtLLovZ
         iA4C80k9pgu5DLGIe+7/e1C5G0UE2IngwsoP6k2in79eRuocbGHex3H4Fa1T3FaoxPkt
         SqMKUloCVFX9Ptd/uMdfJ22FXVtobYBzucbQOCa/aBonTpNcXgUr4U5tEu/Nnz3FGNW6
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkYCmzxFtZ+pNCP1urZOYVz3GVAlckblbbr0pEk0OxU=;
        b=J3vNHz20NuhaIVoJ+18e9jZfAffAY3un3DhtVA7L05GLc+LVRb+seZ3VYeU4QI9Klb
         AiBIQERs4Q2bD6EIHYDinIxQWAo5B6Fm1VBiSO7F2D+UPxkQbjTuRClTfAZhgOFPMp8k
         pRqWjgxNDb066lGOQicTFudRBiWFG4OEBrz/twYGlVl3hCQ4bSUVqV1rIDlIdaEMtMKX
         au/dCl9CuCNYEPfGJD1QK9qFBkx2x1WrGxuhtnBr4tZ8r4XRBe9cTF8seKOoL8CwOC1l
         GU32lI3zWFlnbOW20M+C5l3rs/rVPLMEhKJ/goHIrmVxu5uTU7vBEDF0IVGYccmoH70c
         rznA==
X-Gm-Message-State: APjAAAUoNDsrSaTH89NDzsuE7Pdk8YPwdP64jqzW+H7+FIKjAsGkraA1
        6UAVCq0lhRGkIbj14h1wi70=
X-Google-Smtp-Source: APXvYqwazQCFZ7Yaao5farneYpbtyoRqBJAd230ylGrXi5WWlD4zaOhxd06McA0fxf+puUthagPxRg==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr4393606pfe.109.1568817159880;
        Wed, 18 Sep 2019 07:32:39 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::75fa])
        by smtp.gmail.com with ESMTPSA id c9sm1774328pfd.100.2019.09.18.07.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:32:38 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:32:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     "jinshan.xiong@gmail.com" <jinshan.xiong@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jinshan.xiong@uber.com" <jinshan.xiong@uber.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
Message-ID: <20190918143235.kpclo45eo7qye7fs@ast-mbp.dhcp.thefacebook.com>
References: <20190918052406.21385-1-jinshan.xiong@gmail.com>
 <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 18, 2019 at 05:51:10AM +0000, Yonghong Song wrote:
> 
> Adding cc to bpf@vger.kernel.org mailing list since this is really
> bpf related.
> 
> On 9/17/19 10:24 PM, jinshan.xiong@gmail.com wrote:
> > From: Jinshan Xiong <jinshan.xiong@gmail.com>
> > 
> > Invoking bpf program only if kprobe based perf_event has been added into
> > the percpu list. This is essential to make event tracing for cgroup to work
> > properly.
> 
> The issue actually exists for bpf programs with kprobe, uprobe, 
> tracepoint and trace_syscall_enter/exit.
> 
> In all these places, bpf program is called regardless of
> whether there are perf events or not on this cpu.
> This provides bpf programs more opportunities to see
> the events. I guess this is by design.
> Alexei/Daniel, could you clarify?

Yes. It is by design.
When bpf is attached to kprobe it will fire on all cpus.
Per-cpu or per-task or per-cgroup filtering is already done
inside bpf programs.
We cannot make this change now it will break all users.

