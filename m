Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19C72327F2
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgG2XRk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 19:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG2XRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 19:17:39 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095AC0619D2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 16:17:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g4so7363791qki.8
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CNYovUSlSozhjxm7p9tVfMHuCUBAJ0fZkcNTQqRsicQ=;
        b=JZ8A9OrcpMQw7PzPFKrIaTCIVLD2r3hrGLUmB44ZHC3F3vwyfHNW6IrA2rhwSkA4mB
         9E9o05ica4z19AspqJB5jNu+Bi7jdnqPHWOQTE+taztWDp9uf2PdE7nxbiGkMiaIjoYk
         jKxvnTs12Q5qOiacW6gc4V/ogWnXKa6CCTs+sv4jhiVqQRllAWCIXi2B0Fyr55ukczeq
         eEiAy8voEoXQ67nVWb1/1H0gznI3A5Xw8PvuoJHei56R1F8OuyzpnWGw7z4LtY0ENnQQ
         IBjjT4oBLSac1y5bMY5giCFreMfXmYgZAUfEH5RTB+p/Aus79d7OO5tHOxxt4H0ONclZ
         8xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CNYovUSlSozhjxm7p9tVfMHuCUBAJ0fZkcNTQqRsicQ=;
        b=TQL3qyp55+cA9fK8dk33fYhcN7G1PP5YAv/KKqbZhVN/qx2HR98apoe3PqfEJxiWwz
         +WjZQtKofciUvUIlvt7tOXOTX6ekDZ/dnNk0R/8UEQCa9P8YJnXuitj0PLA9QU1FNNa4
         D8pyD5N4jYafAsH4bb5W8FXqGYT7OeteliV4tVYsJ4jiAsg/SDEOotA1Buc8eDkO0BnN
         +HjZkTHtMbYvYNAvgTQkodaJQ3Z0CLoEb7CznN9dClzD6HQhoTUIBHLItPWAeIsjMl2f
         wxSp9uTe4pjTQVg2WUisSvdQvT5prpI1w/fB0BrkZaHZUYKPZf7CMH+tP949waaktTJf
         V7vA==
X-Gm-Message-State: AOAM530RK/DYPZC3Lsr+KvcC+KjnPUMvHpUEuTd5Er7USFhKd2l7QEnt
        Dctkg0W4M7JbH2OfZmbThmzR9Zo=
X-Google-Smtp-Source: ABdhPJwWxvxIFEhwnipyT4FdwAoC14gZIH4KdL72XuItPweLbh6BVEsu6X7eL92dhU3VK54/jf9HUpA=
X-Received: by 2002:a0c:cc87:: with SMTP id f7mr294971qvl.188.1596064657977;
 Wed, 29 Jul 2020 16:17:37 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:17:35 -0700
In-Reply-To: <92a04281-8bfb-78ec-25b0-fa7adf8dd9c5@iogearbox.net>
Message-Id: <20200729231735.GD184844@google.com>
Mime-Version: 1.0
References: <20200729003104.1280813-1-sdf@google.com> <92a04281-8bfb-78ec-25b0-fa7adf8dd9c5@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] bpf: expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK
From:   sdf@google.com
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/30, Daniel Borkmann wrote:
> On 7/29/20 2:31 AM, Stanislav Fomichev wrote:
[..]
> sock_addr_func_proto() also lists the BPF_FUNC_sk_storage_delete. Should  
> we add
> that one as well for sock_filter_func_proto()? Presumably create/release  
> doesn't
> make sense, but any use case for bind hook?
Right, I didn't think delete makes sense for create/release, but maybe
it does for post_bind :-/
Let me put it on my list, I'll follow up!
