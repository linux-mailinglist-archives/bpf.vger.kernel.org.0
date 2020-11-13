Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5F2B23A3
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKMSZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 13:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKMSZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 13:25:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D27C0617A6
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 10:25:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so9315350wmd.4
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5gT1sncz2gHkJ8mfZXjdkrmB0EKJ+rRT9HBVkP2LpJY=;
        b=OOtbCEahN6iPPcU21Zq1kvc7UDoToKkinZI8owW54M4fn2WzRpcEcTVGo1xQuEVojE
         rdh/GqWCkiSb6HuU/v47cjd1qlMdRq8GZf0hNlZiaXjfMqIKStn1oz4Rr+11/JV9pKmP
         c09VVdScuIw4mw9iXd6PZm8dBVfZNwpPN50Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5gT1sncz2gHkJ8mfZXjdkrmB0EKJ+rRT9HBVkP2LpJY=;
        b=LLJQQGTKpzMVJug7cmRKi2UW1Oc9Aejb41VXp4HRTm/sg2PfkCCwFTb/US/RYNu+7O
         w9wz06z8MJsHjs68rtYwLbnDC399+hkjkB1EZ3lHU1Dl17/EoXCFc8nJqUCtjSb9QKMA
         XygJL/t+XA9J9wLpds40X7W+Fz9Kjj5TS05VSeg9RtVuHyrSv73Sx/ZZgYzA9tPNjV65
         pQBtrJ/6S0ilE2vHX9se5WAze8oy5QHWwDPnZgVwxS7ul4G6HRV2bDzIRFtgssQiKHOG
         vPEirRn84y9doNuvNBT65Gm43SRoP7WixKKH4hHsUXfSBx8nzvRERntT/+PbDYyCly6m
         l6RA==
X-Gm-Message-State: AOAM5301lLmINXHJHcPVIP15b4C7tqzZJliBF1Rkyza/GnDyvvnDBVsC
        dtC9Id9quZTUfpmxhlvp8Ug9WQ==
X-Google-Smtp-Source: ABdhPJxvwtwfylRoN3nAjiwCOXLFYMCb7AZ5BgztG/kOQulyvJM9+JtDW/hZVi2yW4ncBNeLfXe7wA==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr3833562wme.153.1605291905082;
        Fri, 13 Nov 2020 10:25:05 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id n128sm11543583wmb.46.2020.11.13.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:25:04 -0800 (PST)
Message-ID: <5872d768dec1e94d616eee3b3c02d9d148940da5.camel@chromium.org>
Subject: Re: saner sock_from_file() calling conventions (was Re: [PATCH]
 bpf: Expose a bpf_sock_from_file helper to tracing programs)
From:   Florent Revest <revest@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, yhs@fb.com, andrii@kernel.org, kpsingh@chromium.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@google.com>, netdev@vger.kernel.org
Date:   Fri, 13 Nov 2020 19:25:03 +0100
In-Reply-To: <20201112202829.GD3576660@ZenIV.linux.org.uk>
References: <20201112200944.2726451-1-revest@chromium.org>
         <20201112202829.GD3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-11-12 at 20:28 +0000, Al Viro wrote:
> On Thu, Nov 12, 2020 at 09:09:44PM +0100, Florent Revest wrote:
> > From: Florent Revest <revest@google.com>
> > 
> > eBPF programs can already check whether a file is a socket using
> > file->f_op == &socket_file_ops but they can not convert file-
> > >private_data into a struct socket with BTF information. For that,
> > we need a new helper that is essentially just a wrapper for
> > sock_from_file.
> > 
> > sock_from_file can set an err value but this is only set to
> > -ENOTSOCK when the return value is NULL so it's useless superfluous
> > information.
> 
> That's a wrong way to handle that kind of stuff.  *IF*
> sock_from_file() really has no need to return an error, its calling
> conventions ought to be changed. OTOH, if that is not the case, your
> API is a landmine.
> 
> That needs to be dealt with by netdev folks, rather than quietly
> papered over in BPF code.

Sounds good to me. :) What do netdev folks think of this ?

> It does appear that there's no realistic cause to ever need other
> errors there (well, short of some clown attaching a hook, pardon the
> obscenity), so I would recommend something like the patch below
> (completely untested):

Thanks for taking the time but is this the patch you meant to send?

> sanitize sock_from_file() calling conventions
> 
> deal with error value (always -ENOTSOCK) in the callers
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 3b20e21604e7..07b33c1f34a9 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -168,7 +168,6 @@ EXPORT_SYMBOL(seq_read);
>  ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct seq_file *m = iocb->ki_filp->private_data;
> -	size_t size = iov_iter_count(iter);
>  	size_t copied = 0;
>  	size_t n;
>  	void *p;
> @@ -208,14 +207,11 @@ ssize_t seq_read_iter(struct kiocb *iocb,
> struct iov_iter *iter)
>  	}
>  	/* if not empty - flush it first */
>  	if (m->count) {
> -		n = min(m->count, size);
> -		if (copy_to_iter(m->buf + m->from, n, iter) != n)
> -			goto Efault;
> +		n = copy_to_iter(m->buf + m->from, m->count, iter);
>  		m->count -= n;
>  		m->from += n;
> -		size -= n;
>  		copied += n;
> -		if (!size)
> +		if (!iov_iter_count(iter) || m->count)
>  			goto Done;
>  	}
>  	/* we need at least one record in buffer */
> @@ -249,6 +245,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct
> iov_iter *iter)
>  	goto Done;
>  Fill:
>  	/* they want more? let's try to get some more */
> +	/* m->count is positive and there's space left in iter */
>  	while (1) {
>  		size_t offs = m->count;
>  		loff_t pos = m->index;
> @@ -263,7 +260,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct
> iov_iter *iter)
>  			err = PTR_ERR(p);
>  			break;
>  		}
> -		if (m->count >= size)
> +		if (m->count >= iov_iter_count(iter))
>  			break;
>  		err = m->op->show(m, p);
>  		if (seq_has_overflowed(m) || err) {
> @@ -273,16 +270,14 @@ ssize_t seq_read_iter(struct kiocb *iocb,
> struct iov_iter *iter)
>  		}
>  	}
>  	m->op->stop(m, p);
> -	n = min(m->count, size);
> -	if (copy_to_iter(m->buf, n, iter) != n)
> -		goto Efault;
> +	n = copy_to_iter(m->buf, m->count, iter);
>  	copied += n;
>  	m->count -= n;
>  	m->from = n;
>  Done:
> -	if (!copied)
> -		copied = err;
> -	else {
> +	if (unlikely(!copied)) {
> +		copied = m->count ? -EFAULT : err;
> +	} else {
>  		iocb->ki_pos += copied;
>  		m->read_pos += copied;
>  	}
> @@ -291,9 +286,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct
> iov_iter *iter)
>  Enomem:
>  	err = -ENOMEM;
>  	goto Done;
> -Efault:
> -	err = -EFAULT;
> -	goto Done;
>  }
>  EXPORT_SYMBOL(seq_read_iter);

