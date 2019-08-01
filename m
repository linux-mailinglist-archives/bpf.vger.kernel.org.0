Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C07E4A1
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2019 23:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfHAVLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Aug 2019 17:11:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43845 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389063AbfHAVLh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Aug 2019 17:11:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so25740212pld.10
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2019 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xsv49hI9aGpjljOtgVwnXuEAi7FmjxIKLfqfg5dOL8=;
        b=NkhQbzpD4PFe0yt8N8n6078PZiu8nThoyzO+eWHONiylH5RDAwbpNe7a0OXIHacMcG
         Zm1IdF1ZAQTZJjczh2XUEqQN89wkYo23sVUjnZEPki33dJfdldxjKgUQzkMjOga+mmul
         TmJ1Mm7bdmc2Nn2vD0kvLs83SpzEUvXdZLf4JJkcm9PrQ7o4gzeOGJPwKsVP1JThvyeP
         0Gu3SIzi0N9A+p7cO+SEkNiUSElovhZVL16XqojpOHOHQJgobXpcpWTkOvJM/yOCs7v0
         xcbMm1EZh6XEZNAsUhw6KXEGKhYxLOjUuJnF+y8+SPz3jKtsJIY4DZGa74rNR320924o
         lmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xsv49hI9aGpjljOtgVwnXuEAi7FmjxIKLfqfg5dOL8=;
        b=fGusGJBo9Gsl7wwdIn7k98+NVYCrYKYZ93bjo1i7JWA7KvzoWJ9MxutIryTamM+89w
         gW/IzGByGkGEWfpJKWf7vZ31UMXzWajbDha320cfHvuSrIzsMYZSdMB9Nuny3piAxwgZ
         p7mo0jLMUhjsIeckCvUJDn2clqcsY4Dp185sXzfqF4qIigVseegvWN13CrMzrtORSCuj
         wDJT8MjK3uqJu6ZfovqjFCnCly9WO/OlMiwWr5/N97EVeVReFnXDFgwBjdTUxMo6Koc6
         A/oqHeZxtkulRKk4LA+wYw1IQIJzLCvwSgcM7F0klvXfOX7Dn6rtqXZ03xPQsckYrfUe
         zMJQ==
X-Gm-Message-State: APjAAAXcZCkBMKAsQ6KRDwYxzz5JGCZXDFFd6BuxCwH4iGtvGOIavk9X
        4LcXcZ2zxSNRDIaBfj/V/q8=
X-Google-Smtp-Source: APXvYqxMexpp9J8fnGl+bPhCseDlFmUhIGPFD20kLE91/lw53v7y7XMLXyig2C4wfsow7MF8zC2J8A==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr79221609plo.42.1564693896774;
        Thu, 01 Aug 2019 14:11:36 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id e10sm75633361pfi.173.2019.08.01.14.11.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:11:36 -0700 (PDT)
Date:   Thu, 1 Aug 2019 14:11:35 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 0/2] bpf: allocate extra memory for setsockopt
 hook buffer
Message-ID: <20190801211135.GA4544@mini-arch>
References: <20190729215111.209219-1-sdf@google.com>
 <20190801205807.ruqvljfzcxpdrrfu@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801205807.ruqvljfzcxpdrrfu@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/01, Alexei Starovoitov wrote:
> On Mon, Jul 29, 2019 at 02:51:09PM -0700, Stanislav Fomichev wrote:
> > Current setsockopt hook is limited to the size of the buffer that
> > user had supplied. Since we always allocate memory and copy the value
> > into kernel space, allocate just a little bit more in case BPF
> > program needs to override input data with a larger value.
> > 
> > The canonical example is TCP_CONGESTION socket option where
> > input buffer is a string and if user calls it with a short string,
> > BPF program has no way of extending it.
> > 
> > The tests are extended with TCP_CONGESTION use case.
> 
> Applied, Thanks
> 
> Please consider integrating test_sockopt* into test_progs.
Sure, will take a look. I think I didn't do it initially
because these tests create/move to cgroups and test_progs
do simple tests with BPF_PROG_TEST_RUN.
