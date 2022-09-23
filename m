Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E65E7DE0
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIWPFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiIWPFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 11:05:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93950DF066;
        Fri, 23 Sep 2022 08:05:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso2973344wmk.2;
        Fri, 23 Sep 2022 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=S1qtkZsCimc0bFiQuX5IHvT9C5pm95R4wJmpj4GAnEc=;
        b=hG1mpQSA/nM+t1cRg2a6BFYyZL1Y+evNVWLWctb9VVbOh5hlFufcid5iEOwCf8wsh1
         xz3cAfXMAVBhQcjWRt+leXtIONtQ2aYsZqRdweRvGVmXlfJc7d0v9a8/1aLyRP8LStiX
         XJes9wq6L2Gj0EJ8G+zXSwY6fBVb+c6pKdH2Kv7FXbpSIg+C4YklOT3TvQkv5KyTc0Kk
         Z+jo7VR8J5JMw5omYUxBQrfWA1Kj4PH/6PP6y5UwC6jncYcbUArq6EJF967k+0qOoST9
         6My/tGvtL5bGaNfBSuWMvYj1nFoOxIE07dyy7SImZfZ3UHlEnue0mc+6PPOTBz8iOydj
         kn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=S1qtkZsCimc0bFiQuX5IHvT9C5pm95R4wJmpj4GAnEc=;
        b=ICgn2nlVPvxx7uDXgzV6yTiQqrA0QVqbM+v2eI9zWgIFo2e3+KNk9bCYd65y7Bag1R
         wgvhROUSZgdXZQ9qUijSw1legEOEp1Eb8lP12PHBF5F/JF3XT+gTs+gpPS99s70Gq2Ig
         wtGH3nPHuwG6casPj8vw7FnuLwmuMve4TXnhJpQim5p8i/pTWTfLfSlDwVmMgp0qF3vM
         qQz7ZqFefrNnANgVAOjskHuBBR2DovU6+ni1JTF5R0JG0gIjBi9sOb9EgTKYwgceda8u
         TPJyhcF4VXDzoGi+jV7TPCwJfVhu2MIMw6TqIvIWEatvHsJmJhNmedcaDm5XabqR2kir
         39KA==
X-Gm-Message-State: ACrzQf2vMTa30u94cI8Ty/8hE9JYLQqScviaiTZHvd+WRek7DmDJ8sIc
        Zsh8rEhLusYF61kkMIb7kMQ=
X-Google-Smtp-Source: AMsMyM7hGGK8RuhEr/O6ilSvhFpIs40LQmejWASmZUnptTjT8Oyx3IJEWG4DGLk86lVY90iwldIMQg==
X-Received: by 2002:a05:600c:198d:b0:3b4:b6b6:6fa with SMTP id t13-20020a05600c198d00b003b4b6b606famr13426430wmq.110.1663945544966;
        Fri, 23 Sep 2022 08:05:44 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c35c800b003a84375d0d1sm2932506wmq.44.2022.09.23.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:05:44 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <87tu4zsfse.fsf@meer.lwn.net> (Jonathan Corbet's message of "Thu,
        22 Sep 2022 07:24:33 -0600")
Date:   Fri, 23 Sep 2022 15:58:14 +0100
Message-ID: <m2h70y87eh.fsf@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
        <20220922115257.99815-2-donald.hunter@gmail.com>
        <87tu4zsfse.fsf@meer.lwn.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Donald Hunter <donald.hunter@gmail.com> writes:
>
>> Run make in list of subdirs to build generated sources and migrate
>> userspace-api/media to use this instead of being a special case.
>>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>
> This could really use a bit more information on exactly what you're
> doing and why you want to do it.

What would you like me to add? Something like:

"... in preparation for running a generator script to produce .csv data
used by bpf documentation"

> Beyond that, I would *really* like to see more use of Sphinx extensions
> for this kind of special-case build rather than hacking in more
> special-purpose scripts.  Is there a reason why it couldn't be done that
> way?

I looked at writing the BPF program types as a Sphinx extension but
found that approach problematic for the following reasons:

- This needs to run both in the kernel tree and the libbpf Github
  project. The tree layouts are different so the relative paths to
  source files are different. I don't see an elegant way to handle this
  inline in a .rst file. This can easily be handled in Makefiles
  that are specific to each project.

- It makes use of csv-table which does all the heavy lifting to produce
  the desired output.

- I have zero experience of extending Sphinx.

I thought about submitting this directly to the libbpf Github project
and then just linking from the kernel docs to the page about program
types in the libbpf project docs. But I think it is preferable to master
the gen-bpf-progtypes.sh script in the kernel tree where it can be
maintained in the same repo as the libbpf.c source file it parses.
