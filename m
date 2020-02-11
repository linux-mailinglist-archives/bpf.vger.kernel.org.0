Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8741158ED8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 13:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBKMpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 07:45:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36814 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBKMpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 07:45:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so12231230wru.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2020 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C9q8BGu7IB7PXt2yUMUBykDSQ0B6YXHjWHvkwjJyPU4=;
        b=Mz/Z2r+UYxnjdLLVzkoZoBQVAuezwg4Xnwp3DOGa2wS7dUDOCMCMfxYlGRovBodSYd
         1eoYYXHQI0cvtBwC45WV5/QfIxbvaGM3+Mq5paj29D1BmneE39YBBXxE2vhYJyjmgQNA
         cfD6Ae6hI59JebLeC5+AswAzqZMnHk02PwZjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9q8BGu7IB7PXt2yUMUBykDSQ0B6YXHjWHvkwjJyPU4=;
        b=cloiRM5jYoYkyhmb6CU/vfWbiF1ZBGtVsoeM3zD9OhITKg496gZfM4/JpPch1dK6mQ
         dU+YcFzawEnUo1b6/X0POt6JdPHIKqxEYAKaiG2rWu49ceFJ1DI5QObyDm6qIyYtu74+
         LmJb8rL+Tw5sPAuhBkXV77qZJ8W5buXVQR5CLS06LOXkksmQxI18SkgW8HAhiPXOyPan
         vQnYABgZi/r+0XZIRM+VI0/X69rvPUah8ULLkxesCsc+4kyUstd88NvNFV6ptr7HQHbp
         BegQqAFRmzNc2+Zn0lQAkaiAbct7qmWV0bwqlkocYU2E1ifoLYp79OkVY69d/8T9gWuN
         KmyQ==
X-Gm-Message-State: APjAAAURfxFBS4hkCpo5H10axPAAne0w3XByYyiE0Y4HFsAV7LkQ1A4J
        mwBePLQ1RpaZaRfJQpryWm46Ig==
X-Google-Smtp-Source: APXvYqzAKYr3XKAmFzgDScO7mcJ05XPCyWTrDngMYlhcutSKBK5Ht3CrGf4S4X8JhNdaS07YsYKUNg==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr8281334wrr.312.1581425149398;
        Tue, 11 Feb 2020 04:45:49 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id w15sm5371585wrs.80.2020.02.11.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:45:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 11 Feb 2020 13:45:47 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 02/10] bpf: lsm: Add a skeleton and config
 options
Message-ID: <20200211124547.GC96694@google.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-3-kpsingh@chromium.org>
 <20200210235214.ypb56vrkvzol3qdu@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210235214.ypb56vrkvzol3qdu@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10-Feb 15:52, Alexei Starovoitov wrote:
> On Thu, Jan 23, 2020 at 07:24:32AM -0800, KP Singh wrote:
> >  
> > +BPF SECURITY MODULE
> > +M:	KP Singh <kpsingh@chromium.org>
> > +L:	linux-security-module@vger.kernel.org
> > +L:	bpf@vger.kernel.org
> > +S:	Maintained
> > +F:	security/bpf/
> 
> Instead of creating new entry I think it's more appropriate
> to add this to main BPF entry like:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c74e4ea714a5..f656ddec0722 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3147,6 +3147,7 @@ R:        Martin KaFai Lau <kafai@fb.com>
>  R:     Song Liu <songliubraving@fb.com>
>  R:     Yonghong Song <yhs@fb.com>
>  R:     Andrii Nakryiko <andriin@fb.com>
> +R:     KP Singh <kpsingh@chromium.org>

I am okay with this too :) Will update it in the next revision.

- KP

>  L:     netdev@vger.kernel.org
>  L:     bpf@vger.kernel.org
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> @@ -3172,6 +3173,7 @@ F:        samples/bpf/
>  F:     tools/bpf/
>  F:     tools/lib/bpf/
>  F:     tools/testing/selftests/bpf/
> +F:     security/bpf/
>  K:     bpf
>  N:     bpf
