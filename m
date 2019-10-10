Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35907D339C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfJJVpl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 17:45:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44854 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfJJVpl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 17:45:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so4727844pfn.11
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YIwBZ8aS6SvSsNGLqbHbhINAaz2ab0wlA9dmvdVVM4A=;
        b=YdUcl4NpTdqvCC+9YJ3lFg0qzAfx6ZRf8kViaCgvniR+b8+UvLDqd3k+90T23fv/WX
         Zdvb5//zmBY2tUQXJsZ9a+4FyAx60YmQRgRVoK94H2lPS6yClkYtg4tuYEE5rdMz9Hoq
         dhxs59xRlrAPfLKOPTb8hzuUkOgnAiOEUI96Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YIwBZ8aS6SvSsNGLqbHbhINAaz2ab0wlA9dmvdVVM4A=;
        b=QuRdAukOvBY71vgKJ7ofeghCeE2D6SL5HIZYqFhsZcQECwFJniOCeBRPaRXFKfIbZd
         BeeAdZytnNKvHVQXLaTsk6fB2XkDC6D6hkmx9NPFIsTUgujW+SiFrJA8zFegHvD6vnNm
         zFMJWxvMZdlqi2mqiNEZQ2TwfGaVxaaX10g+eb9b6sc2w+CeLYzxaRx188qkn4nDAxvp
         jpC3oSyPesF0hXZTj7I7KDGNreL0cCD0Zxynww5ugpBJjihpNN2H+/hffcWcKY09k6Bb
         jp8KvwMrUPtACFZkqHcW6TW/8+vUfRn9Ne2WFwjC7YhRvabOF8gkuDqZx5ICVuGr37W9
         BXpA==
X-Gm-Message-State: APjAAAXRq3T8Zj3fbRK80gQphRg9OSe8fUiaa2EBpFWtma2y765kjjDS
        lV1uXACkonaRGo3GgBethcKjiA==
X-Google-Smtp-Source: APXvYqyQf310R9Gl7pU6wEC+GhqsWKyvknakgQyAn5yPpF0unj06W2k6/h/uG4GXF1QJH/R7hOEkjQ==
X-Received: by 2002:a62:1b43:: with SMTP id b64mr12428894pfb.56.1570743940731;
        Thu, 10 Oct 2019 14:45:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z189sm6230165pgz.53.2019.10.10.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:45:39 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:45:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     luto@amacapital.net, jannh@google.com, wad@chromium.org,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2 1/3] seccomp: add SECCOMP_USER_NOTIF_FLAG_CONTINUE
Message-ID: <201910101440.17A13952@keescook>
References: <20190920083007.11475-1-christian.brauner@ubuntu.com>
 <20190920083007.11475-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920083007.11475-2-christian.brauner@ubuntu.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 20, 2019 at 10:30:05AM +0200, Christian Brauner wrote:
> + * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF.
> + * For SECCOMP_RET_USER_NOTIF filters acting on the same syscall the uppermost
> + * filter takes precedence. This means that the uppermost
> + * SECCOMP_RET_USER_NOTIF filter can override any SECCOMP_IOCTL_NOTIF_SEND from
> + * lower filters essentially allowing all syscalls to pass by using
> + * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_USER_NOTIF can
                                                          ^^^^^^^^^^^^^^
This is meant to read RET_TRACE, yes?

> + * equally be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.

I rewrote this paragraph with that corrected and swapping some
"upper/lower" to "most recently added" etc:

+ * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
+ * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
+ * same syscall, the most recently added filter takes precedence. This means
+ * that the new SECCOMP_RET_USER_NOTIF filter can override any
+ * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
+ * such filtered syscalls to be executed by sending the response
+ * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
+ * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.


Ultimately, I think this caveat is fine. RET_USER_NOTIF and RET_TRACE are
both used from the "process manager" use-case. The benefits of "continue"
semantics here outweighs the RET_USER_NOTIF and RET_TRACE "bypass". If
we end up in a situation where we need to deal with some kind of
nesting where this is a problem in practice, we can revisit this.

Applied to my for-next/seccomp. Thanks!

-- 
Kees Cook
