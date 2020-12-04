Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7402CED3B
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbgLDLif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387809AbgLDLif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 06:38:35 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7DC0613D1
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 03:37:49 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id c7so5483117edv.6
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/5q64OY61wzCnWatvtkjXNfR8kKGr4RK5RSr9o37dSs=;
        b=Nfq5eghm4m0LNrQx7asnUel3uwFMewpZQ10LMkoJBKGziyNg/93fPL/JdTFnlnfxq/
         wup7E+WM4ePgd+8syBND6EVUxYo7JcfBxecW5JuaOPMjZkH69hqF2cw8VhDPOcgak8bB
         Nja70J3moiTtR7eBFnRm18nohuGDXkjt30SlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/5q64OY61wzCnWatvtkjXNfR8kKGr4RK5RSr9o37dSs=;
        b=PQzzF+6ITkof/TVetti9TdeIJkCAkIvu84nhlvUDEoggr3JDpOyHf+U3eNWdunsQvD
         /KtVUbQO1dc+DHUrNBG79Jl+KwoJkIQsmCROKmVAbLk09ESoxo3o3GSaTK7zFDJrEB6l
         sl5e+bHDz+IZ6ZmiUDIJQyzXAnTu7OyWAzt3BgV6wxETNjWGoInkTbsyNDD9PvCr3ip5
         CAAm8tLpUw2eyjeKSL389vdjh1mA9WG91zgD4gXDUi27cqtAq7K7Lzf4O1CVglJy1LKV
         t6WL/mL5HLC4qztB2n8QOdZ3cruXVu9xfkl4hGF8iCo5wpmss10N2R1s7jNZ/p2fghIp
         Mohw==
X-Gm-Message-State: AOAM530+KVm+bBGyN35pvJkjUr4IND6ZV0MdgmKlsO4NpvXOYHwS0C7J
        8xG+6giW9vYqTNBDC9DuAHHK2w==
X-Google-Smtp-Source: ABdhPJx3wkUTuLT0Ta0U3b1SMRYf+tKoFANM7EslX2bgOqZR4lynsRV/H9eA44uPcAqwQWuu9+eWVw==
X-Received: by 2002:a50:b404:: with SMTP id b4mr7076349edh.369.1607081867885;
        Fri, 04 Dec 2020 03:37:47 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id h16sm2959205eji.110.2020.12.04.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:37:47 -0800 (PST)
Message-ID: <d94fd42e02ffeb8dc51ab6cfb4a4025e42ec1aba.camel@chromium.org>
Subject: Re: [PATCH bpf-next v4 6/6] bpf: Test bpf_sk_storage_get in tcp
 iterators
From:   Florent Revest <revest@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, viro@zeniv.linux.org.uk, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Fri, 04 Dec 2020 12:37:46 +0100
In-Reply-To: <20201204020551.egjexugorxumgarv@kafai-mbp.dhcp.thefacebook.com>
References: <20201202205527.984965-1-revest@google.com>
         <20201202205527.984965-6-revest@google.com>
         <20201204020551.egjexugorxumgarv@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-12-03 at 18:05 -0800, Martin KaFai Lau wrote:
> On Wed, Dec 02, 2020 at 09:55:27PM +0100, Florent Revest wrote:
> > This extends the existing bpf_sk_storage_get test where a socket is
> > created and tagged with its creator's pid by a task_file iterator.
> > 
> > A TCP iterator is now also used at the end of the test to negate
> > the
> > values already stored in the local storage. The test therefore
> > expects
> > -getpid() to be stored in the local storage.
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_iter.c        | 13 +++++++++++++
> >  .../progs/bpf_iter_bpf_sk_storage_helpers.c    | 18
> > ++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 9336d0f18331..b8362147c9e3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -978,6 +978,8 @@ static void test_bpf_sk_storage_delete(void)
> >  /* This creates a socket and its local storage. It then runs a
> > task_iter BPF
> >   * program that replaces the existing socket local storage with
> > the tgid of the
> >   * only task owning a file descriptor to this socket, this
> > process, prog_tests.
> > + * It then runs a tcp socket iterator that negates the value in
> > the existing
> > + * socket local storage, the test verifies that the resulting
> > value is -pid.
> >   */
> >  static void test_bpf_sk_storage_get(void)
> >  {
> > @@ -994,6 +996,10 @@ static void test_bpf_sk_storage_get(void)
> >  	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
> >  		goto out;
> >  
> > +	err = listen(sock_fd, 1);
> > +	if (CHECK(err != 0, "listen", "errno: %d\n", errno))
> > +		goto out;
> 
> 		goto close_socket;
> 
> > +
> >  	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
> >  
> >  	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
> > @@ -1007,6 +1013,13 @@ static void test_bpf_sk_storage_get(void)
> >  	      "map value wasn't set correctly (expected %d, got %d,
> > err=%d)\n",
> >  	      getpid(), val, err);
> The failure of this CHECK here should "goto close_socket;" now.
> 
> Others LGTM.
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Ah good points, thanks! Fixed in v5 :)

