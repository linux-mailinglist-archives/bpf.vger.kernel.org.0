Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5B10F25C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfLBVtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 16:49:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLBVtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Dec 2019 16:49:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id i5so400653pgj.9
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PH5rAfJlRyn8q19ji6GepRAzUZJM4EEqv75vjx7WGSA=;
        b=hU3YnGcnL1BVo0KJqYCg3Yz7tFUJr5beQ0w2GUAcsQdpyfM3EDlpyauMfH7rhTEkfU
         Zzt6+0QWgAVGvZS0vNgG+qORlxBtLCl5ft8lopJuxhF1iZEY7ilyv4Jbt3LkRXRLeJ6o
         +ceYBwLm3AlJi/xcclAH0i6hPlr198x8LIeqRuQuDJLgRwdqg1fT6HUr2b94lW4Cc6RU
         aQjfXJR1hDndevxaPIAeoCa+u5D0sQSR1KXNwMDR1tuLAUAH0wh2siZGg9DjpEjxKKKI
         W2UeoATvME5JyXDEqPdDYtimMQJ49/blJWvZN4jdcINgtKjb0j+V7kXBLUxKo3paHGot
         HrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PH5rAfJlRyn8q19ji6GepRAzUZJM4EEqv75vjx7WGSA=;
        b=onYMlLd+XyeffdNjk4Lrs0yr5poIvpQHuY13512g+fOUf6PaQE4bgHdWmOZBIpaVPq
         hNug7bv99LO1JwkPbmUk6Y6OhPpkrPc3KwXiWd2WIRaRfcbsEko7vUXmpQhm36VarqO8
         6A0/RwrPXx2iB4PjMqmzLW+JivuduKv+c5iMkouA278rO7GcCYw1bxPP0XC8pVSNK2/M
         Nkphqe3XtAlhbN+nwkGm3++2ElTwqbBJFQiUgceHPyfGFpArUAHLYIEQh4pgJug7eKoD
         WWniJZN9xq15Lki/1IlYBmAzebts2YekfWEsr4UYfrkUhcqR9zYdv88YKh0e6ofq3SPj
         qoBw==
X-Gm-Message-State: APjAAAXFJHi19CMn9sgg4mP8klZM5I611zyyIfBLQ7b3ulZJ1SK9nYkw
        3VKGoJf9MdJVeMz+Dv96b3hiag==
X-Google-Smtp-Source: APXvYqw5EbKy+H8CM80uqfh4Fc2QYXwkiHSbrp8OChrZppo8ykLLO28b+mlbIWWQDKp2w+igvwxW0w==
X-Received: by 2002:a65:6104:: with SMTP id z4mr1370359pgu.7.1575323378210;
        Mon, 02 Dec 2019 13:49:38 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z19sm462794pfn.49.2019.12.02.13.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 13:49:37 -0800 (PST)
Date:   Mon, 2 Dec 2019 13:49:35 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] selftests/bpf: bring back c++ include/link test
Message-ID: <20191202214935.GA202854@mini-arch>
References: <20191202202112.167120-1-sdf@google.com>
 <CAEf4BzZGOSAFU-75hymmv2pThs_WJd+o25zFO0q4XQ=mWpYgZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZGOSAFU-75hymmv2pThs_WJd+o25zFO0q4XQ=mWpYgZA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/02, Andrii Nakryiko wrote:
> On Mon, Dec 2, 2019 at 12:28 PM Stanislav Fomichev <sdf@google.com> wrote:
> > +# Make sure we are able to include and link libbpf against c++.
> > +$(OUTPUT)/test_cpp: test_cpp.cpp $(BPFOBJ)
> > +       $(CXX) $(CFLAGS) $^ -lelf -o $@
> 
> let's use $(LDLIBS) instead here
Sure, I'll send a v2 with $(LDLIBS); it might be worth doing for
consistency.

Just curious: any particular reason you want to do it?
(looking it tools/build/features, I don't see any possible -lelf
cross-dependency)
