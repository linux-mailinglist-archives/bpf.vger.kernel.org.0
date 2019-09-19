Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A93B8102
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2019 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbfISSp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Sep 2019 14:45:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37266 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389977AbfISSp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Sep 2019 14:45:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so3144299lff.4
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2019 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6x6IoLBeD+Hx0URt7utINsjtgmBshMnt8x8t4E9SAMs=;
        b=yZKlMf6FYE11fpd6NN/7RIQYCXKzlUqURWPJXgVHSC+qpba/NZezJ1lvV/HNx8g1KH
         uOhljAYj63OS2TVRYpq4PrHhNqxzqyXLybjbdvOK7t9KRmNjIVheYz1mHYcSciJGy0xH
         1f6VKyN57KIAz79bwRZtrl1lGDC55Cz3X3SjgtpfVbfosr9kbXPP9gAI+AdfHtDHU9EM
         q2hngh/5mxptkeEr11BUUDBj8QUroXwtz9IORIufbs2FxZv6wgypLEQ4Zq9hltxl17j9
         mfTiyNUWRJ4JtTBbZ7ni4qVVGeZ7cRz71LxFE6EB8ntzrX3uHLcwdejv8XgIdZ0mz6vp
         1lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6x6IoLBeD+Hx0URt7utINsjtgmBshMnt8x8t4E9SAMs=;
        b=RTqvQaxXCA57ytBiPbEhxuKEpoUxekCp69e3ZI6ziOfQnVNuhv0+XVytJV502ZJsIl
         4LlaApskLgS6YZCuJreRC8kXe42uL4XG+dH65jyCh+tFho4YgY5csrQFQkbxX5mzz2sL
         xllawIsXSws0G4vhnmW4D+f/1wC/pV3AY1y0WQSnh2IOmieJxvCZf5XsKdPhpxJO8oIi
         fk3ris9HIeNMkOdx3gjXyM8v1kb5WioVd/uev+1YUvqcknV1LKNQveMi/wpr2pTPmLB0
         abDp4Hlqj4EMCSHV/5yngS4tg+l3EkmxV+av32L7KDjdqb9KwEoUd9Tl2uyBdmXQ/IJy
         qsqg==
X-Gm-Message-State: APjAAAWVhPDMNobBcaLYWzw9/QL/k3W7XwLVD3Jl6u0CZRIuFLnex3fK
        ZQoXrpi9ljcFPPfk/OscwoLAlg==
X-Google-Smtp-Source: APXvYqy0aYWongyeQd7BLOO2fiBSbf1KIZQS+we11vbX1OHriVVKNSgpoVq4Jj5Ij61LIkD6SyKg9A==
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr5745609lfm.105.1568918725909;
        Thu, 19 Sep 2019 11:45:25 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id i17sm1806523ljd.2.2019.09.19.11.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 11:45:25 -0700 (PDT)
Date:   Thu, 19 Sep 2019 21:45:23 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, andriin@fb.com
Cc:     yhs@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] libbpf: fix version identification on busybox
Message-ID: <20190919184521.GB8870@khorivan>
Mail-Followup-To: ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com, yhs@fb.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919160518.25901-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190919160518.25901-1-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 19, 2019 at 07:05:18PM +0300, Ivan Khoronzhuk wrote:
>It's very often for embedded to have stripped version of sort in
>busybox, when no -V option present. It breaks build natively on target
>board causing recursive loop.
>
>BusyBox v1.24.1 (2019-04-06 04:09:16 UTC) multi-call binary. \
>Usage: sort [-nrugMcszbdfimSTokt] [-o FILE] [-k \
>start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...
>
>Lets modify command a little to avoid -V option.
>
>Fixes: dadb81d0afe732 ("libbpf: make libbpf.map source of truth for libbpf version")
>
>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>---
>
>Based on bpf/master
>
> tools/lib/bpf/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>index c6f94cffe06e..a12490ad6215 100644
>--- a/tools/lib/bpf/Makefile
>+++ b/tools/lib/bpf/Makefile
>@@ -3,7 +3,7 @@
>
> LIBBPF_VERSION := $(shell \
> 	grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>-	sort -rV | head -n1 | cut -d'_' -f2)
>+	cut -d'_' -f2 | sort -r | head -n1)
> LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))

Also can be replaced a lidder harder, with:

LIBBPFMAP := $(shell cat libbpf.map)
LIBBPF_VERSIONS := $(sort $(patsubst %;,%,$(patsubst LIBBPF_%,%,$(filter LIBBPF_%, $(LIBBPFMAP)))))
LIBBPF_VERSION := $(word $(words $(LIBBPF_VERSIONS)), $(LIBBPF_VERSIONS))

You choose, I'm not sure in "sort" of make the same on all systems.

>
> MAKEFLAGS += --no-print-directory
>-- 
>2.17.1
>

-- 
Regards,
Ivan Khoronzhuk
