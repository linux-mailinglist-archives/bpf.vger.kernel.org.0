Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0E3199ED
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 07:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBLGZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 01:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBLGZu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 01:25:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D39C061756
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 22:25:10 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id g21so3744932ljl.3
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 22:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYqt1QM/7f1kV9t9UjXibrj9N0cw2sbo+dJNlMn+sj8=;
        b=QX4pxLnqmkUriiyLUzyZ4CCyj979uhVgyb/E5SJyNOxd91T5ETXuutn4QpxrZYhhmA
         xmXzDJZSNtlYGrkcztvPnqKW3vkPXT3DSAHs1HFmwQV6Z2poqHNjN8xPSBzDMTLqonue
         hs1WrWG+7oeFGGM3Ke1+zcUOTQyLQWHL6zbaOzV6jrEM2Mu4AitTArLIoet9vD3F9Wv0
         lCC1wwGpQiEmEaopPH0BEuO1eF2zVJGe3zGvLXjUB5ZGYb64bM26foTa10Spv+Zm1rV2
         V67ZEF4nfHlP1zHlNdMe2XMFcpHpcAwx24eht0F6a3vZx4iEmmFPwYQANvqbp7pS2Sl+
         bFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYqt1QM/7f1kV9t9UjXibrj9N0cw2sbo+dJNlMn+sj8=;
        b=m5p9bnL8cG1u9d9qGSyZA3H8o04c1aqJQthHdzh0AfKqsGZwrJ8OTMqoPJyrAsVCmY
         aePqEexx+guMdcMssn75++3+zokebdNgtvrMau03WVoYC2lCk5qa5CYQKPgZqpQ9ul8J
         u37Hlx9NtPHlEey8pu8X7JJGchCdyDAUpANBry+MNFaDIPOhQxf/s7lohnGql6ueXHdC
         rkbV6wB01e6En43oaApbvt0VZ6AlQa2x4/X3hbU4acnoNjzd9or0vkXkL3Z4zQ6Loyai
         qYc+HBgThpYEFmQQ4ShNgBDZwfO+P8MbtDnwTzvsRHe4cIAE280/pM4+IySv6UDrq2M3
         FEtw==
X-Gm-Message-State: AOAM533sFJM9DZ6PQvjRXvIUJlaL9ZZvyBuheIiPgaB4xBT7jjqLw7id
        +hwDKonAXZX7hsakAcQ4rIBx9OmNKB3SoKPsHfE=
X-Google-Smtp-Source: ABdhPJxHHpza4pQopwXPSJ6nR9l1hsjH0i5neePAVtBnIj483wlyXLz3Gq3PZOF94QTl51yI0BNt2V4JB+C29D7A19k=
X-Received: by 2002:a2e:700c:: with SMTP id l12mr834641ljc.236.1613111108886;
 Thu, 11 Feb 2021 22:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20210210142853.82203-1-iii@linux.ibm.com>
In-Reply-To: <20210210142853.82203-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Feb 2021 22:24:57 -0800
Message-ID: <CAADnVQLJ9cdgZw5vryddYU0-f-7ST9JF+crR7HMUmTB7WOdbjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs: bpf: Clarify BPF_CMPXCHG wording
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 6:29 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Based on [1], BPF_CMPXCHG should always load the old value into R0. The
> phrasing in bpf.rst is somewhat ambiguous in this regard, improve it to
> make this aspect crystal clear.
>
>   [1] https://lore.kernel.org/bpf/CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com/
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied.
