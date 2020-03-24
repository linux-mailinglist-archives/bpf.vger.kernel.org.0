Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1459D191936
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCXSdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:33:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCXSdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 14:33:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id e1so2737941plt.9
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2LDhmPGgksoORBYsVldX+awgJg6yM4TQVCLJOVvQyz4=;
        b=T7DJhDYuMjXgKVhvaR13cI7YtMJw36RfORxHbnpmHSJHf+FJ4mzurw9+9eu3aG1hey
         wcvVsWV+FhtMo6rF4IpFMCkwmg6T5aQU7rUmzCkMn+ucj+iWDSF9DiizOoNKLp+4WZzt
         s+A5BBhj6yVmMsM1i4ia46rL5rNp+KTYOgDis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2LDhmPGgksoORBYsVldX+awgJg6yM4TQVCLJOVvQyz4=;
        b=OvbIZzeijFT4D7EzlzxKeOXa4fQBC5WAI7rzrdlrh1faqJ0M5u+BGgocsjIMnvVcKY
         bIhSG/p8/Dq9w6aJsZj3dUTX61yHFdbrQbZKYKfupO004R3jAlNQpUw6LN3+rVj5XPMz
         NB+eJcpy6+vg4p48i+ZcZ+6iQD67HxIc7L29a1OsiMmpKWkS0q9MGlYemHl0zaNuQYBc
         sa8xV7FDD9kqdqdVI6XFvaSKyOk8OEkeQk4GcaBaaGT3lhPWOszkrAgzWb4ddApHov5i
         EO2fJtapPb94G9XLUmaJSw4gX+gbpvI2APDwKyF+ycAH3UN9hQA/PtF1830JfynBXTjM
         qm4A==
X-Gm-Message-State: ANhLgQ3gpbusgzzPWO27sU+rfuyAj1f5lGJ3/oKcsSm8BIdM4WqhxSpm
        tSD0MqXtPwEKyQnfmRHHzB/XpQ==
X-Google-Smtp-Source: ADFU+vvgbcz6Wt/SKJaFRiL+RAA8RKi7rgtSKvXONvciu9Bb1JJtlU3ttRoKj0XWQ2BwU+GwGGqB7Q==
X-Received: by 2002:a17:90b:3d1:: with SMTP id go17mr6230921pjb.99.1585074784269;
        Tue, 24 Mar 2020 11:33:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o20sm1095681pjr.35.2020.03.24.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:33:03 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:33:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
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
Message-ID: <202003241132.8F46BC0A@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 24, 2020 at 02:21:30PM -0400, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 2:06 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 11:01, Kees Cook wrote:
> > > Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> > > SELinux's need here? I.e. it can already examine that a hook is being
> > > created for the LSM (since it has a distinct type, etc)?
> >
> > I was about to say the same, specifically for the BPF use-case, we do
> > have the "bpf_prog" i.e. :
> >
> > "Do a check when the kernel generate and return a file descriptor for
> > eBPF programs."
> >
> > SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
> > providing a callback for this hook.
> 
> Ok.  In that case do we really need the capable() check here at all?

IMO, this is for systems without SELinux, where they're using the
capabilities as the basic policy for MAC management.

-- 
Kees Cook
