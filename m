Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC3195E77
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgC0TRg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:17:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0TRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:17:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so12795992wro.7
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hh6WYJqT/M6VdZCxRRGFJ4X3bio1m9J2mQ8vyCBUNIY=;
        b=Aj5KuCp5rUlAQ6zF28nJ3B92q65AO0KaTlRq7Hiod12FrJbTDddzKrzAevJvITTfmr
         tSOgGVEdlR8yytc4R3UmpYwQ3nAisNYbKiSV98g3m+K8js1jSHsICGH+oZDRLvLutkB4
         W1Kg+U/SFAKQNWSdnCyBeag5nqvbfKf4rlZrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hh6WYJqT/M6VdZCxRRGFJ4X3bio1m9J2mQ8vyCBUNIY=;
        b=W6CuUFgqplsv8rfO0J0RvyhwgGx7jOABGPMkOgdPYPsUEQe2QVNrGA6H+Y/XVbkOtX
         dx1Wi05Ze1M91PORmXW+DIgVnw+pWWRx+tyPxih+FF308srQ1YZ+5aJssF1IszxeOn6M
         XPJLriI9CD3wyIGENH+KwJtVfJlaxpdUZiJCRnNcmWSSx9GbRR9eMTjiitOtD7LSyMjb
         h38IWEp+lWFdjaNEqVuRLU8gxplTRL1Nzc7Dq/3B11kSC8x+hM0aMVjAfeNvYuAUi0S2
         vPmMVxEIPQHcvDLeWNzJGRPCg1ieBR7Gqn9QFdEZpxZkwUDB9WNYWTVHdl3JVSLyiHwZ
         UTyA==
X-Gm-Message-State: ANhLgQ0htPd8atvMxbFfzVZF80Y7tjcVM79B+vgwfUXNv91tSd56tkpC
        amqhnUF3H5BGZhhHednptRsr1g==
X-Google-Smtp-Source: ADFU+vsR7STlVYO4IV6+sb1UEbSKtqgoJjlapPf0cVHt271rMf3b6PMAe2TvKL793EyB2zae3Sc3Bw==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr935606wrq.69.1585336654111;
        Fri, 27 Mar 2020 12:17:34 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id d6sm9333648wrw.10.2020.03.27.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:17:33 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 20:17:31 +0100
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327191731.GA9419@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
 <20200327124115.GA8318@chromium.org>
 <14ff822f-3ca5-7ebb-3df6-dd02249169d2@tycho.nsa.gov>
 <a3f6d9f8-6425-af28-d472-fad642439b69@schaufler-ca.com>
 <202003271143.71E0C591C1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003271143.71E0C591C1@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 27-Mär 11:59, Kees Cook wrote:
> On Fri, Mar 27, 2020 at 09:36:15AM -0700, Casey Schaufler wrote:
> > On 3/27/2020 6:43 AM, Stephen Smalley wrote:
> > > On 3/27/20 8:41 AM, KP Singh wrote:
> > >> On 27-Mär 08:27, Stephen Smalley wrote:
> > >>>>> +        return -EPERM;

[...]

> > >
> > > I would favor removing the CAP_MAC_ADMIN check here, and implementing it in a bpf_prog hook for Smack and AppArmor if they want that.  SELinux would implement its own check in its existing bpf_prog hook.
> > >
> > The whole notion of one security module calling into another for permission
> > to do something still gives me the heebee jeebees, but if more nimble minds
> > than mine think this is a good idea I won't nack it.
> 
> Well, it's a hook into BPF prog creation, not the BPF LSM specifically,
> so that's why I think it's general enough control without it being
> directly weird. :)
> 
> As far as dropping CAP_MAC_ADMIN, yeah, that should be fine. Creating LSM
> BPF programs already requires CAP_SYS_ADMIN, so for SELinux-less systems,
> that's likely fine. If we need to change the BPF program creation access
> control in the future we can revisit it then.

Sounds good, I will send out v8 carrying James and Andri's
Acks/Review tags, CAP_MAC_ADMIN check removed and some other minor
fixes.

- KP

> 
> -- 
> Kees Cook
