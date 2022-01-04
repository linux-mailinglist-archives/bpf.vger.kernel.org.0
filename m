Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3348398D
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 01:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiADA4a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 19:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiADA4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 19:56:30 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E4C061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 16:56:29 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id u21so44004752oie.10
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0Uwuc7pP5poUiBOIu/sezUZR16RCfuF9o0myYNiTeQ=;
        b=Y5S7SogglNw6gXi3vO8lz5Z76v4nJNjiTpw+3QEoYbgqOiS2OPSYkrUD6PfVQU0SPr
         3sweYiS2c7CiaxQj40XJSiIXb/wBeaB2xg6QorGC1FjXzaUWbpkZZyBGY6mVxnVXY2oc
         MTdeE++tMe5RDpKyFno567wM+Qodooa3h/I0n2Hlu5uzPDODnUHeUCXJ/wvymdhJQ9mM
         miQuoa15K5342ZeyhAb3GJOCXwd6YtSq7YzB2GfyjoajYUFg2NClxgZxZJ39fSsaMBiM
         8GtaqE7U67WK3j36MQdIlPjtS6YUKiNrexGmZLO2QpZFVmlqnksqg7ZtDmCGBJc2d6Nv
         fhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0Uwuc7pP5poUiBOIu/sezUZR16RCfuF9o0myYNiTeQ=;
        b=4xlBATl8FIkjy9YhZ/YyfMnj/txMLCHmXl7UWAQVVaAXyLV9ej7CMMpDZQelCyy+nc
         u3/yF1SAc2sfUTwXKrMOzqpLHesgsjQRvELIgDA6GTEmIz8uuHUtidRJePuzf6kHJ+YX
         jF1ektkpCauIbRHrY0xfwUq0NeyyaZ/KEInMprlE49HLhuq3piDBdsSqZMlcJrUlLIOk
         WDZf884gglsF4V2FTWIlD79D1glD2FfIOVQfqBQSn6zBVX9v4nLVk+5QX/5VauKY5GKl
         BEEZhPovZS6Bu7aRdQ0EZa2WnvVZFLdBg+TWk6jzmzYr1ilWy4j24L29CAy/9tEIuyff
         yIkQ==
X-Gm-Message-State: AOAM532S9BO6IVIrcb8l4c9g5HhxEKONgzrq0UYzmw5eyCOskvYjpBES
        ywYazgNuLhbOartVIdt8fJi4Jjj8j5M=
X-Google-Smtp-Source: ABdhPJyWIue+MIW1IKkOvNYmObqzHLelzMLPMWfTpVKMKMfT46HNR/iY4PYCuKrYkClmFwFQr4iOGQ==
X-Received: by 2002:a05:6808:144d:: with SMTP id x13mr38931977oiv.25.1641257789307;
        Mon, 03 Jan 2022 16:56:29 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:73a2:abf:ebbe:9103])
        by smtp.gmail.com with ESMTPSA id bi20sm9660799oib.29.2022.01.03.16.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 16:56:29 -0800 (PST)
Date:   Mon, 3 Jan 2022 16:56:28 -0800
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Jhonny Knaak de Vargas <jhonny.knaak@protonmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Some questions about EBPF
Message-ID: <YdObPAA6L43g4QZX@pop-os.localdomain>
References: <f9526881379a8d5f2c27e2fe5843885d648b31ec.camel@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9526881379a8d5f2c27e2fe5843885d648b31ec.camel@protonmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 02, 2022 at 08:02:01PM +0000, Jhonny Knaak de Vargas wrote:
> Hi,
> Got some quick questions,
> Consider that I am a newbie just studying.
> 
> 1. How can I subscribe to the list? This link seems to not be valid
> anymore http://vger.kernel.org/vger-lists.html#bpf

It should work.

> 
> 2. What I want to do:
> 	My idea is from user space set the pid of a process to the bpf
> program on the kernel side.
> 	On the kernel side I want to have a variable which will have
> that PID that came from user space. Now,I want to identify writes to
> memory that process owns.
> 
>    Question:
> 	I am not sure if I should be looking to use kernel headers for
> identifying the memory pages of a process or should I be reading /proc?
> 
> 	Can you guys please give me some tips on how to achieve that?

Where exactly do you hook for identifying memory writes?

I guess it may already provide some context for you to follow to find
out the process.

And you can always use eBPF map to communicate with user-space to filter
processes with PID's.

Thanks.
