Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2A15531
	for <lists+bpf@lfdr.de>; Mon,  6 May 2019 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEFVAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 May 2019 17:00:35 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42867 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfEFVAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 May 2019 17:00:31 -0400
Received: by mail-qt1-f173.google.com with SMTP id p20so16539612qtc.9
        for <bpf@vger.kernel.org>; Mon, 06 May 2019 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3wJRQ6VKWRxL27a5QxEQoOQCJUnNTmSip3XDWhvdBaQ=;
        b=A/lSskv2O+Uy1ln/4WsjLObJSCsYlFzGzAWfWBpCgQp9nJ+T99/ChlO5vaAVXQQYq1
         kDaLE662WickGYjmxtVJdcvsq7kbFg4eC4W16FIdZCN7C2VGClGEdQDMahn3ZhHRkxpz
         xIiZn7TZq4GQZTSQxsdL3I9hj6RlHCaA9RvYcxeBBfDIV/gJAtL4IGK1GyNFw5ACccvr
         cZ2eUhhH0dV8ZgUOM7Un1kQSqKXNjDsZnpU1zGcN0N71PRXpRelhx4MLGkHG5W9T6Npv
         y9Wtzcv1SgLUUVHhBJVhRcCciD8eRu8h4dAs/HDyUMOPXIM1H+KtNqfsI1DVDUYMxByn
         pMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3wJRQ6VKWRxL27a5QxEQoOQCJUnNTmSip3XDWhvdBaQ=;
        b=raHe4HY/tlsSnokPR+6idF8q+nzqqbV8+nj6x/I/eof6Y39Yb4liFpxt8HRdRrhH7i
         qI+yeKIhyfpqG0omEj4CMOAIMP0PKi5K3FRo0yIxsQdqIlYPm0RgLKh831uzv1NIH9Ns
         QhGLLwHGEUz35psDgFA1jNysRvAQ0hjcOOyauFuOXfRS/t2NYpZi5irGVl20OOIYx1s0
         GiBbEl60ayegA/oSryed4Wxp8IaPn9QnzoSVpBHxmadGNjAiGfVTGIFw+czhqbrHGmtz
         sI5xmW/Vd8BE+Iu5//nINUs8ji0NMk/M1vDDz6tL+S9wOc4uTQdD5cpEtY2lTYvJKAyi
         W9rA==
X-Gm-Message-State: APjAAAUevDMG7I7llmOEGCR8V7jEPVxi5YqxAvhhqreiAesQ4grP/LFN
        ocVTono/SAyM+JUAcSX2nfPZiw==
X-Google-Smtp-Source: APXvYqx/0CijmHQT5nAegd8Iq3bmLEJ/dSOVuelYyGhdUDs4JSPE3rCKI5bh09sk4kBRUcTwpfs8uA==
X-Received: by 2002:ac8:743:: with SMTP id k3mr20214481qth.207.1557176430476;
        Mon, 06 May 2019 14:00:30 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 67sm5934254qtc.29.2019.05.06.14.00.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 14:00:30 -0700 (PDT)
Date:   Mon, 6 May 2019 14:00:22 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, linux-kernel@vger.kernel.org,
        xdp-newbies@vger.kernel.org, valdis@vt.edu
Subject: Re: netronome/nfp/bpf/jit.c cannot be build with -O3
Message-ID: <20190506140022.188d2b84@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <673b885183fb64f1cbb3ed2387524077@natalenko.name>
References: <673b885183fb64f1cbb3ed2387524077@natalenko.name>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 06 May 2019 21:40:07 +0200, Oleksandr Natalenko wrote:
> Hi.
> 
> Obligatory disclaimer: building the kernel with -O3 is a non-standard 
> thing done via this patch [1], but I've asked people in #kernelnewbies, 
> and it was suggested that the issue should be still investigated.
> 
> So, with v5.1 kernel release I cannot build the kernel with -O3 anymore. 
> It fails as shown below:

Any chance you could try different compiler versions?  The code in
question does not look too unusual.  Could you try if removing
FIELD_FIT() on line 326 makes a difference?
