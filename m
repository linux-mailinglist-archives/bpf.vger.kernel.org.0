Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C419193C
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCXSe4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:34:56 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52438 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgCXSez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 14:34:55 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so1981709pjb.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mx9h2G9Pa234gVddEgnTViqlM2nzOYE5T6EE2ivPTBA=;
        b=X8BpTUshqVTp5ZrfGENJjA7S8D3PMkC1H9raELqRdSdjLNe5sZB5Y4RMX/nghlzJ8E
         1CsWUkd+SHVMvC1UIUpx6JTnz1l2RNGsNZUks9+wLQ7kIaqQcNp/2bungkmZ4F+++aNv
         F9F+k+zvWPAIpXVP3evPY5DDeIBLOdTEoj2Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mx9h2G9Pa234gVddEgnTViqlM2nzOYE5T6EE2ivPTBA=;
        b=XeyB/I5yg8kpDAVejIqvpcx8aRLJ09OpejIyn/Mh54K4huWK6iv4dGkwpjtSrhDcjt
         VS85ONIBdql8lcf8HpFVMv84sSNxqmXvth0eSBrNWB78zmT1Fu8sZ4oujir//3tFCd/I
         7xg3Tfq1bX9SllEzYUbhanJ57CznFiiZIr3vpB6Eazg1WhQ0Gbdi7NYsTsKMLCpmp2AL
         ZELzKiwDWd1mLzuIMpX0i4ITSzlaui+ErBOUdxlUZwfhDm4kKbsYuNlbxppK2fgK0YlC
         FmlxUwPqJM2rghHBMfCJiMUeYA8abO3MLdUCzJKdgFibWjOLss23i2nBXr6JNiZCbNXP
         QTpg==
X-Gm-Message-State: ANhLgQ2xQCMLtcPZEcWcAoMXVhA5Jwyay02QsvCu6Vyiku9L6ef1nbQN
        ZCOHrSWe9F0KqE2137QjaNtGwQ==
X-Google-Smtp-Source: ADFU+vuY4HhM8vNaIQSER7/NiwCNGWQLQ6U2UpEtoYs0U+twgNdazhReNufRdZraq2u/dEMlw6NdIQ==
X-Received: by 2002:a17:902:850a:: with SMTP id bj10mr27476778plb.28.1585074894587;
        Tue, 24 Mar 2020 11:34:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x135sm15801559pgx.41.2020.03.24.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:34:53 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <202003241133.16C02BE5B@keescook>
References: <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
 <20200324182759.GA5557@chromium.org>
 <20200324183130.GA6784@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324183130.GA6784@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 24, 2020 at 07:31:30PM +0100, KP Singh wrote:
> On 24-Mär 19:27, KP Singh wrote:
> > We do not have a specific capable check for BPF_PROG_TYPE_LSM programs
> > now. There is a general check which requires CAP_SYS_ADMIN when
> > unprivileged BPF is disabled:
> > 
> > in kernel/bpf/sycall.c:
> > 
> >         if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> > 	        return -EPERM;
> > 
> > AFAIK, Most distros disable unprivileged eBPF.
> > 
> > Now that I look at this, I think we might need a CAP_MAC_ADMIN check
> > though as unprivileged BPF being enabled will result in an
> > unprivileged user being able to load MAC policies.
> 
> Actually we do have an extra check for loading BPF programs:
> 
> 
> in kernel/bpf/syscall.c:bpf_prog_load
> 
> 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
> 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
> 	    !capable(CAP_SYS_ADMIN))
> 		return -EPERM;
> 
> Do you think we still need a CAP_MAC_ADMIN check for LSM programs?

IMO, these are distinct privileges on the non-SELinux system. I think
your patch is fine as-is.

-- 
Kees Cook
