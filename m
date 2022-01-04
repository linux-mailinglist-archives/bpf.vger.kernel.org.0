Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79581483984
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiADAo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 19:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiADAo5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 19:44:57 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49675C061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 16:44:57 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id be32so57133133oib.11
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXAVCtJYI2UobZzDOsVJbBiWYu66PY1YkRh1XnTWDaM=;
        b=JHSm12xpJHzVNC6VlxJt+Omn4PFTDbpgNAk0pOep1UHGzuTX9/B4GCclHknqpQwl+H
         tAQiK8NGun7XBOT6ZxUhFW1eyBACjN3aU2i4TUSsYT5SvgYYN1P6LTUheB8ZjQPNEV71
         QTif3Ad7Yy+s//5A7odCXofb8I4oDjGMNd0ZYODXS9iN9WQipRrREoyTErTZrUnklg2O
         4iLoPIS7Fn8/5mYI2biHmY8QCcA3gMdARXX5dZyFp+bYVKTEpiVO+/nnPIASuHfGzwRC
         knR5Sq6fVdLYUCy76EjD7ynypgdkXJlACMWiIqcAkEf96gwqEb078jormdw5GR1tEF0z
         5lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXAVCtJYI2UobZzDOsVJbBiWYu66PY1YkRh1XnTWDaM=;
        b=bC7evyx3oY7fRoDTX7/3jzoyllMK/1V1cgpfFW9WzrRvofi+9TIie9Md4wES9hrZUO
         /nr2ZZBcMhBT+a3UiB72IstRmlyxBLo8SoU4mak93tdoX1Kq2+/AnQPL7z5aZz+QwWF/
         TggvJeYcODuLY138u/m5PylHBwXhEmzk/8OJ8lU55j+hzbFNfyB3TLS8mi5NzaUjX+I/
         SF0gZMjx1fQ1lZGRCJ2ohFYIbD9P7pPtAMFmRw7nM0T6zG58UBatMyguc14NiIpZiXyw
         VrV85zfPEXHwrY8uXXKhdXI890nDl/5L1aJidfclX7NZFvKhccrNMXEm/PNRewSoK79e
         U4Fw==
X-Gm-Message-State: AOAM531bK+pqBGf7iv+KTD6rD+zB3li0lC2ggzhmr+LwxKuvTdOmg6wO
        b+cLgOE6rLIVfSCsnQvqbuHTHOLy/p0=
X-Google-Smtp-Source: ABdhPJxSuJDIvjTC5r15YvspPpxZGutFhUMMxhayII1l5M+T7QjZdifFaKVFMZKH4SKTLY7KzED69g==
X-Received: by 2002:a05:6808:205:: with SMTP id l5mr38600238oie.164.1641257096665;
        Mon, 03 Jan 2022 16:44:56 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:73a2:abf:ebbe:9103])
        by smtp.gmail.com with ESMTPSA id q10sm9471074oiw.17.2022.01.03.16.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 16:44:56 -0800 (PST)
Date:   Mon, 3 Jan 2022 16:44:54 -0800
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     His Shadow <shadowpilot34@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: eBPF sockhash datastructure and stream_parser/stream_verdict
 programs
Message-ID: <YdOYhsVwGu1p/SSu@pop-os.localdomain>
References: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, His

On Mon, Jan 03, 2022 at 03:53:12PM +0300, His Shadow wrote:
> Greeetings. Here's the problem. I've written a simple program, that,
> when a connection is established, it establishes a connection to a
> predetermined target and starts routing traffic between a user
> connection and a new connection.
> I've tried to use ebpf stream_parser/verdict programs for this,
> however there's a problem: when a connection to my program is
> established, client sends the data immediately, however there's a
> delay, while I establish a connection to the target. So stream_verdict
> never gets called, because the data is already in the socket receive
> queue(or maybe I'm misunderstanding something). Is there a way around
> this? Should I use something else, like skb_msg verdict?

Are you saying the packets arrived before you put the socket
into the sockmap? If so, you can consider
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB.

Hope this helps.

Thanks.
