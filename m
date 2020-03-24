Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384351915A4
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCXQGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 12:06:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54181 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgCXQGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 12:06:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so3827673wmj.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1N/kkCsXiaUZJR6Cb6g+LjBhvjr5lmjI4mokCR0tVqI=;
        b=KYQKDx8DyzUAnuq2yoc8TeWYg6u2d9G1EnJpysHS23i/nJtDUTJ1EGMDA+yLtc+3Ne
         ttb5axfZ4dXbmiVTOnc+IEEDAk9zxj2cXn99YKJpGZc93ZuBmxvzsUq8qH6oTtP5O3Yq
         fGk1pmxtTvy5X+ioEB3lY2DmwDertoipWkA38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1N/kkCsXiaUZJR6Cb6g+LjBhvjr5lmjI4mokCR0tVqI=;
        b=DyzrXTYeJAFiTTYGDZQ56R6VHko0wEAOFZfF/U8PXTisObde8bAVkDLgnAb3SEwAVC
         G0qYjttVMoPxt2J2ljygYB9XlEgeJBZxIEmUD3HVgDTrKbqXnxKNNLXL7ESq+t4SnlgM
         jeAkR1gxCZ/2JXVm9TS5vkNap37iRo2VLLhBRorZt/qlZyfFN03EOK2eiFoJ4CoFL0wJ
         oXtql75slMyCEKLylX/hpy3fJzaYS0RJApNiHMalQn9DIJD6cm9UWdqP7JISHU/F/Khy
         z/CttFKIe/L8YOkqqHYP7w722xSM+RTaUDsq0EoP3Gx+yxqsKzFsdVodB9b+XqhA463m
         Z1eQ==
X-Gm-Message-State: ANhLgQ0RTkTMqWj4IA4VAVCtBCAW9mG9rCWLe5Nti0gtLRLi96JFtPRS
        8ShLV1+oOcOida+hIXnOg+2HNQ==
X-Google-Smtp-Source: ADFU+vuG4lJMdGuOPi6DXgu5JzM407RSy855bnUG1UuTb5xJvxQ+7aP+XEs6ZftW2sAQYdGUDfywtg==
X-Received: by 2002:a7b:cf19:: with SMTP id l25mr6240257wmg.131.1585065980936;
        Tue, 24 Mar 2020 09:06:20 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id u204sm4887603wmg.40.2020.03.24.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:06:18 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 17:06:16 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 2/7] security: Refactor declaration of LSM
 hooks
Message-ID: <20200324160616.GA9173@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-3-kpsingh@chromium.org>
 <CAEf4Bza67kM0KiX464yB+iV83aV96TyD7iLEZJccXyH-Od0QTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza67kM0KiX464yB+iV83aV96TyD7iLEZJccXyH-Od0QTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Mär 12:56, Andrii Nakryiko wrote:
> On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The information about the different types of LSM hooks is scattered
> > in two locations i.e. union security_list_options and
> > struct security_hook_heads. Rather than duplicating this information
> > even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> > LSM_HOOK macro in lsm_hook_names.h which is then used to generate all
> > the data structures required by the LSM framework.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  include/linux/lsm_hook_names.h | 354 +++++++++++++++++++
> >  include/linux/lsm_hooks.h      | 622 +--------------------------------
> >  2 files changed, 360 insertions(+), 616 deletions(-)
> >  create mode 100644 include/linux/lsm_hook_names.h
> >
> > diff --git a/include/linux/lsm_hook_names.h b/include/linux/lsm_hook_names.h
> > new file mode 100644
> > index 000000000000..412e4ca24c9b
> > --- /dev/null
> > +++ b/include/linux/lsm_hook_names.h
> 
> It's not really just hook names, it's full hook definitions, no? So
> lsm_hook_defs.h seems a bit more appropriate. Just for consideration,
> not that I care that strongly :)

I like lsm_hook_defs.h better too :) Updated.

- KP

> 
> 
> [...]
