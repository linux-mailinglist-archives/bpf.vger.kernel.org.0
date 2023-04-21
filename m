Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE76EB1E7
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjDUS50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjDUS5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 14:57:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D986A3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 11:57:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a95aef9885so778815ad.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682103443; x=1684695443;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K6w/RFYQCEFH9lIrXtvEwcrLX8h6DWXUYJgShXYznQg=;
        b=OtrMflDqpvTbf1hqYgFRh8MGT+y58+wd0bVv5hinaNy5myW2e97ZbV6smB3QQbXthK
         n+PEWARqKca7qz5yg9HbPtAZgiBOEOtkxE8BazOztgokDXOuZqD5TjxBfo3CScJQjHnN
         efXoJax0DOwqnK8bXbeEpaI/5UiFwmGMkX/Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103443; x=1684695443;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6w/RFYQCEFH9lIrXtvEwcrLX8h6DWXUYJgShXYznQg=;
        b=EjNoHQKzVIWuReompxL/l7mipLT2+bkPk2ggPQwRZPryfapYS+VqAvUddQIoxQRIY5
         6KDOM0O9r/jwpAhEOIwLflV2gFuxc4TMLltWy58SfkJUCvZ1LhbNLgGKZhGPk4DSoKAI
         w3/fznt3fjUSGygMiO+jtV0gA7pd4gnYTbz/2ZvKTeAVFGaTLdwTlHWBIkdkYz8XKfXj
         XI8dYoXkbn9rQiHjAxJFHg9CHKpoZal/lagzF4k5B6BFe0kDQj6NcnjsYrL1Jp9EZpb7
         iCQG4pPxwxcPDbGCgcPm+kwlgCKAnPKAoOJWj3s2QfUmUDtljGf9OQscRZ9rhZVe3fvn
         Sk5Q==
X-Gm-Message-State: AAQBX9eYt44+awHR50jrt9IjVbDNHu3uKYn95YHLgC1y8spQNHQqZtN6
        LfuBwOfV1cyt0DI0H9vfcUbiFw==
X-Google-Smtp-Source: AKy350bG12cuo1lLGTQORAOtsIQ0fMwYcYa1pj62OYt+Y0tHZrEl1aCeqHuo4UlERPx1aBu4AAaXdg==
X-Received: by 2002:a17:902:c405:b0:1a6:f5d5:b80a with SMTP id k5-20020a170902c40500b001a6f5d5b80amr8324490plk.38.1682103443706;
        Fri, 21 Apr 2023 11:57:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm2932293pjq.43.2023.04.21.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:57:23 -0700 (PDT)
Message-ID: <6442dc93.170a0220.aacc4.65b3@mx.google.com>
X-Google-Original-Message-ID: <202304211151.@keescook>
Date:   Fri, 21 Apr 2023 11:57:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
References: <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
 <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
 <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
 <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com>
 <CAHC9VhRH6Z2r_A7YkDEmW7kiCA8e5j2u270gE48jpQmqS+t75A@mail.gmail.com>
 <CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7eSUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7eSUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 05:00:55PM -0700, Andrii Nakryiko wrote:
> Alright. I now do have an alternative approach in mind that will only
> use restrictive LSMs and will still allow BPF usage within user
> namespaces.

It seems the problem with in the existing kernel is that bpf_capable() is
rather inflexible. In only one place is sysctl_unprivileged_bpf_disabled
checked (outside the unprivileged_ebpf_enabled() checks in CPU errata
fixes).

Should CAP_BPF be per-namespace?

-- 
Kees Cook
