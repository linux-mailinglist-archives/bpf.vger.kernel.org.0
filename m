Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45F1FC70
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEOVvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 17:51:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33083 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEOVvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 17:51:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so1622004qtf.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qdrlJuKu0Q1qhfC0AybjFB1KcDf+c+74JEBQB6P60MM=;
        b=e2niVLUgolL8QHs5FIcVJs2//Y6uyfQrdlHwxDKbyeTkr6EJgTOtZegahDE3OTCCxy
         v394Yr01lUgMjBwgIoiz904OhYOOodF8V1dEIUnIzYyTu+1KaYV+jO/unX+6PZ0KO+SO
         jmRx+32s7sfj+6JJiueUq4ybDi5ILp6xybRvxbrnJZLqa5E9bVAZgtU4N9sUhegHbdm3
         DafIozK9jtjDL/A2csvGkffPWOSvyMwgoNl9ztPC+Qtpdd5CchvUjvO0crRr2NRN6Yhs
         6SPMUGY+9iZtuLRuXwL3YsR1zA3cxJG1wd58EXe+xdNx4dEcnWChgNjPiB9uxmp7Y5G+
         eYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qdrlJuKu0Q1qhfC0AybjFB1KcDf+c+74JEBQB6P60MM=;
        b=XlHThdPU+xxLNpukIU4IunSbdClP8U/twyT2/308luhhsAgHBgiVGUoqtY1QP10yw2
         3KSu5drYG4P4LeuH7EF2RJToYuSgPZLr57iSYip3MQmU2Y7udLRu50reGfxbf0sQpDMD
         yZKU9aK31s2I6CiwfozzftRNDaOX0e3LiKer85zKA+yIMSIxm+whk8ATngRbWyIMMUFX
         nzh2ZGtelgL3WzWugLr2ZcLgqL2XyXB/dhTYmXtiIIimLjkA+W4bNvQVKzOC/4gzig7W
         yf/wxpsOkO9V3L9LIDv9hMaqBGPXGnX0n0XM0z+eC04yomQuPpCW/1+88c+3pGMBsWBs
         Q4mA==
X-Gm-Message-State: APjAAAXpkOKGYXNHmi62t3tGweMlxAcFksz/bN/ZmY702Jy57276xNOm
        WnBOoxk68XaEKviO2VYTnfxnmQ==
X-Google-Smtp-Source: APXvYqy5GlU131/uqdPdRXV0T+d4W+Y+VlNd5u/nshND9LPTTZwB9wIixSOZCQVGUna2h2CGkYcQNQ==
X-Received: by 2002:a0c:d48a:: with SMTP id u10mr16627959qvh.169.1557957061893;
        Wed, 15 May 2019 14:51:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a11sm1174992qtp.44.2019.05.15.14.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:51:01 -0700 (PDT)
Date:   Wed, 15 May 2019 14:50:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Krzesimir Nowak <krzesimir@kinvolk.io>
Cc:     bpf@vger.kernel.org, iago@kinvolk.io, alban@kinvolk.io,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Avoid a clobbering of errno
Message-ID: <20190515145037.6918f626@cakuba.netronome.com>
In-Reply-To: <20190515134731.12611-4-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
        <20190515134731.12611-4-krzesimir@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 15 May 2019 15:47:28 +0200, Krzesimir Nowak wrote:
> Save errno right after bpf_prog_test_run returns, so we later check
> the error code actually set by bpf_prog_test_run, not by some libcap
> function.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Fixes: 5a8d5209ac022 ("selftests: bpf: add trivial JSET tests")

This commit (of mine) just moved this code into a helper, the bug is
older:

Fixes: 832c6f2c29ec ("bpf: test make sure to run unpriv test cases in test_verifier")

> Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index bf0da03f593b..514e17246396 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -818,15 +818,17 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>  	__u32 size_tmp = sizeof(tmp);
>  	uint32_t retval;
>  	int err;
> +	int saved_errno;
>  
>  	if (unpriv)
>  		set_admin(true);
>  	err = bpf_prog_test_run(fd_prog, 1, data, size_data,
>  				tmp, &size_tmp, &retval, NULL);
> +	saved_errno = errno;
>  	if (unpriv)
>  		set_admin(false);
>  	if (err) {
> -		switch (errno) {
> +		switch (saved_errno) {
>  		case 524/*ENOTSUPP*/:
>  			printf("Did not run the program (not supported) ");
>  			return 0;

