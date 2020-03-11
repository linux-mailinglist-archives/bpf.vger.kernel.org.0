Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4900181A63
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgCKNws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 09:52:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgCKNwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 09:52:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id a132so2193442wme.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rxH11306lWeDbP7QaiW9KYqcGSQz8G6vvv/cRVSV/WM=;
        b=Fv5Iqnyn1gdF978L/4cLKCAkNKGWgjBiwOreoEv3QaRNWO/9DU7Xs2ybmv7z3AGE1u
         nZ1rX5+bKy8apT8M5SzmjL7GBXPTR24m4NqPPubcDE8cFOq+FabTGxkPWqW6xOteisLR
         bTZx34JTds4l88bNzgi6++PQ+lhHGZw6spHno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rxH11306lWeDbP7QaiW9KYqcGSQz8G6vvv/cRVSV/WM=;
        b=Qx9GhHY31hFeyUV1j1icm6eLp0vns2yUBKdNQmk4L/ShF2r/FuaESwHgq9U/SZ+aau
         sTJj5M5gTw6p6QfEQ2izLDQGQpKIgAYGjI2P9eKOive6+ie2cn0m87COaNxExqN1OLem
         CmJM1pqLmDu8TuLl7k5ZNB6bOM1zN+cs9FweQy62SJx4H57ir+jcTUWvA3PN0qaod5Mk
         oDuLjdVLNHc3jRprZD3TWUs/GfVsaW9zKCk+BkgQL95qbtpSOjDGDykjFqv6cb3G7KeM
         i4Ly3F3GbOP1DKZ4SoByeGdtvoDwRUxwIaPvgAJXwKehOgTmcxgc+eNKedrU4eS/gij+
         YqQw==
X-Gm-Message-State: ANhLgQ1prunF9+PL3aP6WrZgZ1o2xKWH6IKO6vhldSzxE47pZZwLRgKW
        IoNl+t5JMqCbXugsA2ZUp+M8gg==
X-Google-Smtp-Source: ADFU+vuo+4xqkMzJGeG6/6DyfbLS3Y3jsPMS2HMgekvRv41TjxsVjFE/ARVg3j+ncuoQDcnGNjCfmQ==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr3766203wmc.135.1583934761107;
        Wed, 11 Mar 2020 06:52:41 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w1sm7920404wmc.11.2020.03.11.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:52:40 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200310174711.7490-6-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] bpf: sockmap, sockhash: test looking up fds
In-reply-to: <20200310174711.7490-6-lmb@cloudflare.com>
Date:   Wed, 11 Mar 2020 14:52:39 +0100
Message-ID: <87wo7rxal4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> Make sure that looking up an element from the map succeeds,
> and that the fd is valid by using it an fcntl call.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 26 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 52aa468bdccd..929e1e77ecc6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -453,7 +453,7 @@ static void test_lookup_after_delete(int family, int sotype, int mapfd)
>  	xclose(s);
>  }
>
> -static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
> +static void test_lookup_fd(int family, int sotype, int mapfd)
>  {
>  	u32 key, value32;
>  	int err, s;
> @@ -466,7 +466,7 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
>  			       sizeof(value32), 1, 0);
>  	if (mapfd < 0) {
>  		FAIL_ERRNO("map_create");
> -		goto close;
> +		goto close_sock;
>  	}
>
>  	key = 0;
> @@ -475,11 +475,25 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
>
>  	errno = 0;
>  	err = bpf_map_lookup_elem(mapfd, &key, &value32);
> -	if (!err || errno != ENOSPC)
> -		FAIL_ERRNO("map_lookup: expected ENOSPC");
> +	if (err) {
> +		FAIL_ERRNO("map_lookup");
> +		goto close_map;
> +	}
>
> +	if ((int)value32 == s) {
> +		FAIL("return value is identical");
> +		goto close;
> +	}
> +
> +	err = fcntl(value32, F_GETFD);
> +	if (err == -1)
> +		FAIL_ERRNO("fcntl");

I would call getsockopt()/getsockname() to assert that the FD lookup
succeeded.  We want to know not only that it's an FD (-EBADFD case), but
also that it's associated with a socket (-ENOTSOCK).

We can go even further, and compare socket cookies to ensure we got an
FD for the expected socket.

Also, I'm wondering if we could keep the -ENOSPC case test-covered by
temporarily dropping NET_ADMIN capability.

> +
> +close:
> +	xclose(value32);
> +close_map:
>  	xclose(mapfd);
> -close:
> +close_sock:
>  	xclose(s);
>  }
>
> @@ -1456,7 +1470,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
>  		/* lookup */
>  		TEST(test_lookup_after_insert),
>  		TEST(test_lookup_after_delete),
> -		TEST(test_lookup_32_bit_value),
> +		TEST(test_lookup_fd),
>  		/* update */
>  		TEST(test_update_existing),
>  		/* races with insert/delete */
