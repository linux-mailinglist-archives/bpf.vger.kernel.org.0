Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78556D1D7C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfJJAk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 20:40:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbfJJAkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 20:40:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2708436pfg.13
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcPd5Jny5aY5aMsPzhLMHUk3eBTerZnA6THOQx3YHYM=;
        b=CQBl48C9FQrJE5k703Kev1+BQ/3whfu6HOkubrefsdeM3B2i5ly4Dw9keO2geTEGUV
         s+Ui79CGMEi8TyPD6oEqp7cslGqZKhXLLTCoggJ/CPYtMcY9bWkjwact3xZFKaXvWZYO
         u5JLNe8rCmmBk2yB39UHSrBbn2Uo+Ciiic/jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcPd5Jny5aY5aMsPzhLMHUk3eBTerZnA6THOQx3YHYM=;
        b=LUcDuXIz45K8gSfKXRo0/ohSA4EfXtnggh7IK/94MyqCM4qje/NbcjSuJiSZBqhx1k
         h+NMWTTP5VkPpVLfrAsB4dZQFyKlozxNQWTOU2Z5MsLYZpWWf/XQTWYhQ4PyMr3FM/JT
         HIzhhHRFr3ZRyPRa4Pc2NE7glG2b5+2BGwc/qhe8PhmyEQtNeWv+hqyjvhFgQg1wNDxS
         t/I9/6E6OLSrDFqa9AaDscyDaocGHUM8bTy6t0k8wERwleCHvU3WGe7VVCr/+LniCBX2
         fFV/KXu1XMlV4qZoB4TGR39VSaFxHPViIc2CLdQrLrrB6peWfFjaWJ7q5Jnh0u46dqrF
         G6wQ==
X-Gm-Message-State: APjAAAX1q+VFxLSQAhqHaks0PAV4kqlZ2c6iBHtRDriUskPRJf80o3JY
        Yews8NWhHFUtuwyw1wUpwsXkiA==
X-Google-Smtp-Source: APXvYqwiMuTGGeU2xAhSzgcNonr+8WNtJueMfhMlVoTbDTnimhgmwYn+zScwE00Wpmxe8o7Phci6AA==
X-Received: by 2002:aa7:93a9:: with SMTP id x9mr6675538pff.81.1570668025033;
        Wed, 09 Oct 2019 17:40:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 22sm3415597pfo.131.2019.10.09.17.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 17:40:24 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:40:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191010004023.GC96813@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
 <alpine.LRH.2.21.1910100912210.29840@namei.org>
 <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 09, 2019 at 03:41:56PM -0700, Casey Schaufler wrote:
> On 10/9/2019 3:14 PM, James Morris wrote:
> > On Wed, 9 Oct 2019, Casey Schaufler wrote:
> >
> >> Please consider making the perf_alloc security blob maintained
> >> by the infrastructure rather than the individual modules. This
> >> will save it having to be changed later.
> > Is anyone planning on using this with full stacking?
> >
> > If not, we don't need the extra code & complexity. Stacking should only 
> > cover what's concretely required by in-tree users.
> 
> I don't believe it's any simpler for SELinux to do the allocation
> than for the infrastructure to do it. I don't see anyone's head
> exploding over the existing infrastructure allocation of blobs.
> We're likely to want it at some point, so why not avoid the hassle
> and delay by doing it the "new" way up front?
> 

I don't see how it can be maintained by the users (assuming you meant
infrastructure as perf_event subsystem). The blob contains a SID which as far
as I know, is specific to SELinux. Do you have an in-tree example of this?

Further, this is also exactly it is done for BPF objects which I used as a
reference.

thanks,

 - Joel

