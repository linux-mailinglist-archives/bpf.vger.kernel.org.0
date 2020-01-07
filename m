Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973BD132EB9
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 19:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgAGSzh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 13:55:37 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54621 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgAGSzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 13:55:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so168487pjb.4;
        Tue, 07 Jan 2020 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r+GrzXgHoS6CEBkNptSroylQzjagajtMKMDuMBvJayw=;
        b=nSbUYHzYcwazJCMli6B1MtzcmfIPediX75Bl4MxjgBOUO/CxrK9HhCXrD37Ca/1w49
         c6UKiZQTwRSMytmOVzQnp1lm5KW4IWmHreoA/t6pgVI+7YwoIMmwFDz0cZXdH8pPq3ho
         PQ7dAhi9/Iev0f2ZZItbiSPhixD4V1f8EOat7LM3K6Pvfh6wYGXUi9RA3DuM8spGR/75
         s3Z9EUXt53HbiBjpkhyjplRrkS/HNNFdOK8pbpu7a8dbbKJpP1u38y2u2LD93nwvBrbC
         RoJVGFvnzlqY0ILcXfRI4Z9hioo0JZwNmuytgZ9/MxMoJTA08r7MBAqgli8mMqO9lbqQ
         np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r+GrzXgHoS6CEBkNptSroylQzjagajtMKMDuMBvJayw=;
        b=hvAvtXtuY+bM6ZC5W4S0aYlow48YETv9Tr2x0M9/4c4R9hDNih8cUGOfNnYuBYech2
         AEznQyQwuvbWiux8ayVXsqmyumWST41veiaP1pdAa1eBEK01ECFai31+VlJZLqF36pBu
         x2+JMvDrxismdnUnKWjS5Bgiwg8KQuuixoS0mS07MMDoktvqhK8BzlXvBZuwt7wR+wzo
         2YtOgGRoqD//LCRtElOCYu4SQqlDnlCtVXRn7htPums+bXgJGh5g2balxREXWM6iW8gf
         hfZeP3A6QBrS9jXB0PQ+KbhTzWxKFRtAdO5bLFzT7SFD1fgebW894Ey/iGNzjBrnRhsA
         ejhg==
X-Gm-Message-State: APjAAAVcd0qWvFhAqWjbMUIvYXRcoTtF3a66Y12iL0mnBNzFbs/U02S8
        uX6yvPkZ0TBz7OC98WPWZqM=
X-Google-Smtp-Source: APXvYqyGiHWa+GRx3474WSDW+p/qBGM+QnaUXP1i0F3KALfloYuNrIXg7QKcZgmP3sJqR5kS4V6i2w==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr1082793plb.309.1578423336209;
        Tue, 07 Jan 2020 10:55:36 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::c4b1])
        by smtp.gmail.com with ESMTPSA id u18sm474443pgi.44.2020.01.07.10.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:55:35 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:55:33 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Justin Capella <justincapella@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Message-ID: <20200107185532.4zax5j5ln456u7rj@ast-mbp>
References: <CAMrEMU8Vsn8rfULqf1gfuYL_-ybqzit29CLYReskaZ8XUroZww@mail.gmail.com>
 <768BAF04-BEBF-489A-8737-B645816B262A@amacapital.net>
 <20200106221317.wpwut2rgw23tdaoo@ast-mbp>
 <20200107091132.GR2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107091132.GR2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 07, 2020 at 10:11:32AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 06, 2020 at 02:13:18PM -0800, Alexei Starovoitov wrote:
> > On Sun, Jan 05, 2020 at 10:33:54AM +0900, Andy Lutomirski wrote:
> > > 
> > > >> On Jan 4, 2020, at 8:03 PM, Justin Capella <justincapella@gmail.com> wrote:
> > > > ﻿
> > > > I'm rather ignorant about this topic but it would make sense to check prior to making executable from a security standpoint wouldn't it? (In support of the (set_memory_ro + set_memory_x)
> > > > 
> > > 
> > > Maybe, depends if it’s structured in a way that’s actually helpful from a security perspective.
> > > 
> > > It doesn’t help that set_memory_x and friends are not optimized at all. These functions are very, very, very slow and adversely affect all CPUs.
> > 
> > That was one of the reason it wasn't done in the first.
> > Also ftrace trampoline break w^x as well.
> 
> Didn't I fix that?

yes. in the tip. many months ago. that's why up-thread I was saying that I'm
waiting for all text_poke[_bp] patches to land upstream and do the same thing
for bpf trampoline and bpf dispatcher (which has the same issue).
