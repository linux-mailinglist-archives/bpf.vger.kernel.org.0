Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F67160A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbfGWK2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 06:28:04 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36998 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387790AbfGWK2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 06:28:04 -0400
Received: by mail-ot1-f51.google.com with SMTP id s20so43482071otp.4
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzjZ9xrgJ3e/N9oCtEjwrojn4zWHBMXyeNDwUYtXGpA=;
        b=IMAR6fvAspFpE2VY2zN47kWU83tie4A+Smh5I1eVnhIRNNrh9o5KpPCjY2/S4IT1xX
         MwoSHeg6j1eHNGeezJD7/3o8HH8XQa0EgZ6QAVMVdkrrGfyOpI8mKdF6jQsXtwje9h5d
         eZwYSm3O7jWCVbxabKaIZYM58itmDAl3XtWrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzjZ9xrgJ3e/N9oCtEjwrojn4zWHBMXyeNDwUYtXGpA=;
        b=pay+ZN6r3DUnZ90i4ewewRGKUEN4HZamE0c0/wODJeC9awTeVa+xVVmaI0zSBBRi41
         554EEXncwDQaS8yWF8dYWrNnS0qknlBXa7oGijPQixP+ER874cVikceLD/KpwJeC0F0Q
         T0Fq5FZlVgxDZWxLUid1i5/DCLouJQkDPGxfyTPpy9Ev0WUc2HGx17FuQD7Tpo4hMTJK
         Fzd2ZUwwwuEDm93Ht3euy5HkhxF0kxzbH076B7nNNX950HisiKllb5fjMSU7pUGyh21Y
         aocmPRwtFTFXVQYgNq2vRNACMjodTn9WQ4P+ZhAK5ZqZ4WirhNPYDpNUWE/+4agA2Xhg
         5yTA==
X-Gm-Message-State: APjAAAWTaEcIKZsgkkZcJeX9Rb1KDCEQVZo3KcWUU18LlGB2Xdqknt/V
        4m/harkbZsWu8q4yq1B011zpN59Mxx6iu1NmcWX01w==
X-Google-Smtp-Source: APXvYqzEpVRw6OPxSjOoqAs6BN44GaYDcArZCOF2x1AMWSijh7TcvOBEmzzr2EMth26lY0YWk4E1HNUjbRO2AGoyfPQ=
X-Received: by 2002:a9d:28:: with SMTP id 37mr53996317ota.289.1563877683237;
 Tue, 23 Jul 2019 03:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002042.105927-1-ppenkov.kernel@gmail.com>
In-Reply-To: <20190723002042.105927-1-ppenkov.kernel@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 23 Jul 2019 11:27:51 +0100
Message-ID: <CACAyw9_6jp6PauEcCSVvc+JJA1VvZgNsYZtuvu5=vf4b0rxkvw@mail.gmail.com>
Subject: Re: [bpf-next 0/6] Introduce a BPF helper to generate SYN cookies
To:     Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        davem@davemloft.net, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jul 2019 at 01:20, Petar Penkov <ppenkov.kernel@gmail.com> wrote:
>
> From: Petar Penkov <ppenkov@google.com>
>
> This patch series introduces a BPF helper function that allows generating SYN
> cookies from BPF. Currently, this helper is enabled at both the TC hook and the
> XDP hook.
>
> The first two patches in the series add/modify several TCP helper functions to
> allow for SKB-less operation, as is the case at the XDP hook.
>
> The third patch introduces the bpf_tcp_gen_syncookie helper function which
> generates a SYN cookie for either XDP or TC programs. The return value of
> this function contains both the MSS value, encoded in the cookie, and the
> cookie itself.
>
> The last three patches sync tools/ and add a test.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
