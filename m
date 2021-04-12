Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC435BF1D
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhDLJCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbhDLI7E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 04:59:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015BC06138C
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 01:56:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w8so11616533lfr.0
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=v80JJJDW9QtxHkk0a0zU0nnrThIy25/WR2Z0y5oalCQ=;
        b=B0FICsUZf5BlugUzF6HFNlkL5xjsucp0vP8Ze+uCdd+R0swzQwgQoJXK+CzHNwyYps
         Idg6A81UHoPEHV2+aO2VHh1yzZWxUDXt0M2lvIN+6AGXURRcLwc18alykY183arV+jv0
         gtKBn//eU/Vh3G5BzOFRBljiadmr8pZ/Oab80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=v80JJJDW9QtxHkk0a0zU0nnrThIy25/WR2Z0y5oalCQ=;
        b=ez/86UlgMr8rjjHsWoWyKt8VZIGjNf93/2Sx0uISedp4SlrJUlN1ST5kZlIP9dBgGA
         x9vrY2yE3XX6+2foX6vRIjEvndzTVO5l6vibagEzGJKjLWNFJAidyes102LVdKge1fhC
         S1RlpUsaQVWnh3AmhzPiYDeTGgQX/mRzPzzRuClcUmUNUlUUgWU5QnkCaDI71An5ViB4
         0fKPzHebZUJC/JH7tgowDyKHAvkYbjPpvB+YxzYVSKLkrTvQN1vh/Co8P4MA9ipXvTcH
         D2I6EF4ET6qI6td67EAULovpKuyYk2ONYo1xmFIobtQy1z4IqfZw/AMDw+owdw1k+0Gt
         BL/g==
X-Gm-Message-State: AOAM532OVoNA95ULhydXYfeEs7/Eo65RDMdhcvh5CdH8vnTf/Gh6grL5
        h6kn7Mau1lCWfkTHmWGu+yMRWA==
X-Google-Smtp-Source: ABdhPJzS8q80Ofl+UQJgn2PmQRSlB7aoaXgbZM87nPxi9zU3guOvIdL4NtCaH8vS1B7vmXTmlb/huA==
X-Received: by 2002:ac2:5617:: with SMTP id v23mr18500507lfd.123.1618217808502;
        Mon, 12 Apr 2021 01:56:48 -0700 (PDT)
Received: from cloudflare.com (79.184.75.85.ipv4.supernova.orange.pl. [79.184.75.85])
        by smtp.gmail.com with ESMTPSA id y25sm2739125ljc.73.2021.04.12.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:56:47 -0700 (PDT)
References: <20210408030556.45134-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        syzbot+7b6548ae483d6f4c64ae@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next] sock_map: fix a potential use-after-free in
 sock_map_close()
In-reply-to: <20210408030556.45134-1-xiyou.wangcong@gmail.com>
Date:   Mon, 12 Apr 2021 10:56:46 +0200
Message-ID: <87pmyz3mpd.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 08, 2021 at 05:05 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> The last refcnt of the psock can be gone right after
> sock_map_remove_links(), so sk_psock_stop() could trigger a UAF.
> The reason why I placed sk_psock_stop() there is to avoid RCU read
> critical section, and more importantly, some callee of
> sock_map_remove_links() is supposed to be called with RCU read lock,
> we can not simply get rid of RCU read lock here. Therefore, the only
> choice we have is to grab an additional refcnt with sk_psock_get()
> and put it back after sk_psock_stop().
>
> Reported-by: syzbot+7b6548ae483d6f4c64ae@syzkaller.appspotmail.com
> Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
