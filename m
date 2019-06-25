Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4152559CD
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFYVTu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 17:19:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32844 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYVTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 17:19:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so144895plo.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=318/F64MRVThD6drKvp6v4JpYRMrYpBkhrwSZcHYF8g=;
        b=U17DEEigSUf+CD2yF2mdyA5DgVlbqsasZHiDw0pR5K2+kgyzPgRBt3UpRLTcziJXia
         IKMSJ7A54jQz2SVVSEctjU/LE+IB/qTrA1X7zFnVKAT4VUCImIUb5WxMrWteKf9kJFqC
         MAX8kK5dGct+kdvxS5nYVgcR3lX9pxVnZt6+zutB4Yj2Re3uzNGGMajKlFHaNBC+w+yP
         mH4WJ6EoOE0SX0I5AXYVs61vmVxxKCmOe+bzfDpKPjgBvUmgOwD813mVUGU0dBAYJ6uV
         fLWZv9PkeoLhrGlZ8Cy3yBVFcsrQFb03RNYa7aVBGX0p6w9uTmwimeLLWRq8/UAetELO
         fO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=318/F64MRVThD6drKvp6v4JpYRMrYpBkhrwSZcHYF8g=;
        b=PIC2lDCL9mUiZXvPX933NuuHPWMy4f8HZR/8oXst3mUYoy9xHCq3Ys4GIG8szjPSiE
         yHUeS10y/QVG03IrvaXAllxz1Xm3PktF1U6iw2CzkAgiM0PYtvwq829QiRL2jvI58xEu
         atKSctX6k98omQJsZwngSC/6dfd6n4MiUIjJ9QEWbKe6xfJO4EKJXlalgpM/HLxTmgfl
         bd7R4J+CRIEDS6QjEe2mbGK/BHzHjBnbBGJS9zK3jS6R8l8e9ZAgc047ChyLsYmwnLBi
         hDlebq1zzfIc4zRlFTMHg4+DCeXkQ9ba8W0NugoOTOQfCmFvf6Ul9HrL75F/OncIFvb8
         OaPw==
X-Gm-Message-State: APjAAAW+Ysxal9Ohr1pygbnjHRDXOs4s47Owp3niNETuBtTiR0bKyhrt
        IEsQM3RhRm0wV0+PJMcDnh4OBA==
X-Google-Smtp-Source: APXvYqw7jLksEyjREhJ+ZuyrcdebDQn94Ed7i5dIPE6ifnX4os+NPpskM24MHLU7YKqaFzarMy7vDg==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3mr851172plt.116.1561497589998;
        Tue, 25 Jun 2019 14:19:49 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z20sm29887527pfk.72.2019.06.25.14.19.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 14:19:49 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:19:48 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/4] sys_bpf() access control via /dev/bpf
Message-ID: <20190625211948.GE10487@mini-arch>
References: <20190625182303.874270-1-songliubraving@fb.com>
 <20190625205155.GD10487@mini-arch>
 <59e56064-354c-d6b9-101a-c698976e6723@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e56064-354c-d6b9-101a-c698976e6723@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/25, Alexei Starovoitov wrote:
> On 6/25/19 1:51 PM, Stanislav Fomichev wrote:
> > On 06/25, Song Liu wrote:
> >> Currently, most access to sys_bpf() is limited to root. However, there are
> >> use cases that would benefit from non-privileged use of sys_bpf(), e.g.
> >> systemd.
> >>
> >> This set introduces a new model to control the access to sys_bpf(). A
> >> special device, /dev/bpf, is introduced to manage access to sys_bpf().
> >> Users with access to open /dev/bpf will be able to access most of
> >> sys_bpf() features. The use can get access to sys_bpf() by opening /dev/bpf
> >> and use ioctl to get/put permission.
> >>
> >> The permission to access sys_bpf() is marked by bit TASK_BPF_FLAG_PERMITTED
> >> in task_struct. During fork(), child will not inherit this bit.
> > 2c: if we are going to have an fd, I'd vote for a proper fd based access
> > checks instead of a per-task flag, so we can do:
> > 	ioctl(fd, BPF_MAP_CREATE, uattr, sizeof(uattr))
> > 
> > (and pass this fd around)
> > 
> > I do understand that it breaks current assumptions that libbpf has,
> > but maybe we can extend _xattr variants to accept optinal fd (and try
> > to fallback to sysctl if it's absent/not working)?
> 
> both of these ideas were discussed at lsfmm where you were present.
> I'm not sure why you're bring it up again?
Did we actually settle on anything? In that case feel free to ignore me,
maybe I missed that. I remember there were pros/cons for both implementations.
