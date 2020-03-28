Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971F219699C
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 22:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgC1VuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 17:50:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40376 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgC1VuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 17:50:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so5016158plk.7
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=CvU8SQl5E+YmYbDxDmbskBQ2t0JHHJQ8sASp0i2I0gH2ECAI5tRnkGDbtdi/C0KT5R
         LbajgCaWikJ72Ca+qnR7CDrJck+PCmajv50Re1zqDdZjjyRVXL4YMc9/4bUJWPVD1kum
         wnnHIQxObr7V1lZf1r4WgKqWIy6wY+zGWsFq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=FUtWTvbEwZ2vxO8SfbTjTcZ9SsIysiCqcYSzaSlMeuvWXBlSDrX8DrkTwYMHJlOTv+
         ZNbByVm0cXCPZNROox7OlTboVM5Mmptmlpq5oEqdrfZac5HmelM/913nkJUo0aTY6Udk
         UXVwtO1535TozD29TLk08NNr7IOONcjWw0gbYDgW64Q3ukwMbPHV6/a2cQNcK1z88Tik
         MNGDmypWXqwOXuCT5Wf5L0nNoRQ10fBJTpPB5A8Vt85DkxOZRFHyoCJRm4HmKmgl0wnE
         wzNg4jGtC8SGx1LgliqoLzoe/ZvQjxsFU0md+WfvSpLDLDO09pilu/3xL5OpeDIiT03M
         JYoA==
X-Gm-Message-State: ANhLgQ33XxAw+2BL7RiKhIDmZR/HcQKggZfFtthzmws9pBXCiX+7en+5
        h613jdxS4pDNgNiwq2iXfxsdBg==
X-Google-Smtp-Source: ADFU+vu2NiUwwEDLHzJMv3dcJEsAb3IO6DOtzKCkclXs6mjC9Cb9juZjNRndmUuOgRpk8swbUuht2A==
X-Received: by 2002:a17:90a:5d96:: with SMTP id t22mr7300491pji.132.1585432216326;
        Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm6820905pfg.170.2020.03.28.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:50:15 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:50:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202003281449.333BDAF6@keescook>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328195636.GA95544@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> Since the attachment succeeds and the hook does not get called, it
> seems like "bpf" LSM is not being initialized and the hook, although
> present, does not get called.
> 
> This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> there by default as we added it to default value of CONFIG_LSM and
> also for other DEFAULT_SECURITY_* options.
> 
> Let me know if that's the case and it fixes it.

Is the selftest expected to at least fail cleanly (i.e. not segfault)
when the BPF LSF is not built into the kernel?

-- 
Kees Cook
