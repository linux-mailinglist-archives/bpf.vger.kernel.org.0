Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18DA181A12
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgCKNog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 09:44:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgCKNof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 09:44:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so2668263wrm.9
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ePCb0df9gTgL2UMkffHBZ8+8Oebpm89G0Wlrp433HuU=;
        b=KRP2PUDeNB/O1UBpVlIMzs05+FLZ8Vdfnk97LeVezQukugJ+Tb80QNk/UMdRkwSe0Y
         5DOBug6jB9Fgib2wxxmU117vUnWT+b+OdSmdTXavoSpLL4lSbreGgBE/dFzu5BKjj51t
         TbifQ3QbaLgTBh052z7ymdH79Lc1iiWhtZ3i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ePCb0df9gTgL2UMkffHBZ8+8Oebpm89G0Wlrp433HuU=;
        b=MAmM/do2mny6lkVmoxvmvYHMEgfkl+5hq31POXeC/D695M+PCd7KURr7sNrihnjX9G
         uYuaeLH6A4GK39l7Msa76T5eVDIGzv5wYSktoBrmax4vnRRAjDkdw1NiDvadXYwIG08V
         DwOHHCXhcpV0vuwijwRT9KaqvQ9kNShQVoTe37BCyWSsTqUrsKUBPN1wKgR/x5/Dt87h
         szCEf/LRGg8yrQ4PLYZyQB8cxjbDCRqj57R+XCOgWhAgkSI0TJlGuVGslDIlE22YpkLo
         i9ZHlkgWGyB9mMBVcRhKT8ufLO7zwF9EdDPBKwMO0zxzzz8q+WBGk2ed0TwzR1Huet/0
         VIrg==
X-Gm-Message-State: ANhLgQ3T+Shx/MsMpTVOg0rn8NtLqetLY+oqreKBPLu0YI876Ds2LVQW
        jZy7Nno/mVDf0MTZq9AdHpvBNA==
X-Google-Smtp-Source: ADFU+vsj1xa7sgaLweZwfOTQi81O2oOmGxS6Ap2wvC/10sv0ZXwVnw+i5qycYS2tqv3VMGLhdPH+Hg==
X-Received: by 2002:adf:e64f:: with SMTP id b15mr1623447wrn.424.1583934273745;
        Wed, 11 Mar 2020 06:44:33 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w15sm6670639wrm.9.2020.03.11.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:44:33 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Lorenz Bauer <lmb@cloudflare.com>, kernel-team@cloudflare.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/5] Return fds from privileged sockhash/sockmap lookup
In-reply-to: <20200310174711.7490-1-lmb@cloudflare.com>
Date:   Wed, 11 Mar 2020 14:44:32 +0100
Message-ID: <87y2s7xayn.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> We want to use sockhash and sockmap to build the control plane for
> our upcoming BPF socket dispatch work. We realised that it's
> difficult to resize or otherwise rebuild these maps if needed,
> because there is no way to get at their contents. This patch set
> allows a privileged user to retrieve fds from these map types,
> which removes this obstacle.

Since it takes just a few lines of code to get an FD for a sock:

	fd = get_unused_fd_flags(O_CLOEXEC);
	if (unlikely(fd < 0))
		return fd;
        fd_install(fd, get_file(sk->sk_socket->file));

... I can't help but wonder where's the catch?

IOW, why wasn't this needed so far?
How does Cilium avoid resizing & rebuilding sockmaps?

Just asking out of curiosity.

[...]
