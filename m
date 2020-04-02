Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC89D19C389
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgDBODB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 10:03:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44116 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbgDBODA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 10:03:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so4303849wrw.11
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fqn7p/l7UwSVEcFtTYwLbDZZfP18GORIXD0/qCGLlHI=;
        b=ayNgC39jRlZElPUbkmOCwcKapm+bAKDE9EO+rfAWTQhemjIpsA312DayojrbJb0+ll
         iHbmk0q3yYT1AVAr731mbxjnPHwij/f0j+J7a/AvmA4GqCjSJKwXNMJiMf1GfRFjoC4C
         nTgTujtXFyF6zy9tCsrkPAxxGsc5MUYHqjBaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fqn7p/l7UwSVEcFtTYwLbDZZfP18GORIXD0/qCGLlHI=;
        b=GHMEqwszjnavmX1Chsy/Js6khsmEEDuN+lvNcV4K32e6pza95QNUSSoW5g77Z7mk8h
         2OMAHY34kp9U0X3ZxGiXBSKWZr+juajikFbD7P+/3LcNvShKEDorx8NA8DvtZCcgsW5S
         Edr9gQSSV0+dtpzl9S3GHCr4GmsXwtpN7YyBuBNJfpE9vhg5CIICF/TkL/UHGlLJk5on
         5Dq3VFviqm7WaFLe9DEoa3hPNAa2mpJw4vOn05bx9URfQ+9fFElmvRVjl+arSgq8P/Ec
         ho6zeK47rlI0NnHRNWNMnG7BzBf9cDu9s6KH9OLFZ6fWrAXx5KyTOqEJrkM4fbgkdGIr
         QgGQ==
X-Gm-Message-State: AGi0PuYkd80Ftpuz9kdYqjoRltKgzgXUpXI7grXJhEvJWA4JvqCTj0qz
        BDCnJjhj7Ho+BH1+HM+e2mjcMTdC0xY=
X-Google-Smtp-Source: APiQypK+8UMfG1mJo59/786/qFE6iY0sUP7qJJoMnX9RQZSEFfXGn9lxL0DMeRUI8e6DiMcBzP3G6w==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr3654797wrt.401.1585836177591;
        Thu, 02 Apr 2020 07:02:57 -0700 (PDT)
Received: from revest.fritz.box ([2a02:168:ff55:0:c8d2:c098:b5ec:e20e])
        by smtp.gmail.com with ESMTPSA id b199sm7965195wme.23.2020.04.02.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:02:56 -0700 (PDT)
Message-ID: <2c93a2c75e55291473370d9805f8dd0484acd5a3.camel@chromium.org>
Subject: Re: [PATCH 2/3] bpf: Add d_path helper
From:   Florent Revest <revest@chromium.org>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bgregg@netflix.com,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 02 Apr 2020 16:02:55 +0200
In-Reply-To: <20200401110907.2669564-3-jolsa@kernel.org>
References: <20200401110907.2669564-1-jolsa@kernel.org>
         <20200401110907.2669564-3-jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+build1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-04-01 at 13:09 +0200, Jiri Olsa wrote:
> + * int bpf_d_path(struct path *path, char *buf, u32 sz)
> + *	Description
> + *		Return full path for given 'struct path' object, which
> + *		needs to be the kernel BTF 'path' object. The path is
> + *		returned in buffer provided 'buf' of size 'sz'.
> + *
> + *	Return
> + *		length of returned string on success, or a negative
> + *		error in case of failure
> + *

You might want to add that d_path is ambiguous since it can add
" (deleted)" at the end of your path and you don't know whether this is
actually part of the file path or not. :) 

> +BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> +{
> +	char *p = d_path(path, buf, sz - 1);

I am curious why you'd use sz - 1 here? In my experience, d_path's
output is 0 limited so you shouldn't need to keep an extra byte for
that (if that was the intention here).

> +	int len;
> +
> +	if (IS_ERR(p)) {
> +		len = PTR_ERR(p);
> +	} else {
> +		len = strlen(p);
> +		if (len && p != buf) {
> +			memmove(buf, p, len);

Have you considered returning the offset within buf instead and let the
BPF program do pointer arithmetics to find the beginning of the string?

> +			buf[len] = 0;

If my previous comment about sz - 1 is true, then this wouldn't be
necessary, you could just use memmove with len + 1.

> +		}
> +	}
> +
> +	return len;
> +}

