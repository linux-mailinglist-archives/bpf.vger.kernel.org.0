Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B11BAB21
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgD0RZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0RZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 13:25:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89AC0610D5
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 10:25:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g74so18770011qke.13
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t3V+QHvWoU5Qt7XuBjaT149yzddN2oFEv2/3nxTJk2c=;
        b=BIJxl2EUHpLWUbKuOQbbXpJkneBhh5Kk6cJXqTO7aLRu/yev2A0Ci6dQWc9f0Ke27u
         VaqEn0th8OPEE1LWQYE6OZjeTHdlWhSKnxCqAWS09X6U8BaGfuEe9twUzKBoxE+JGerL
         F9ZeBsnCgRnLyDc9W+uU5V4qn1Mo3NmHZEzHShEPd1PbhQnNOKAf+IbXGVgDOSxnKjwn
         KMjbOyb7xjJtfEeVbUDyz0PeRAv6B6Les20K7wAa3R7jWTF0v708fpG4R4sBIMwGjksn
         qF9+S76Sk5Qy2efIcDqFW37tcU0V6q5N1VrgMwmAW3oXEwbmlk7YxDCLtTnh08YVCxNN
         AJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3V+QHvWoU5Qt7XuBjaT149yzddN2oFEv2/3nxTJk2c=;
        b=szTGpMm9nUL8WoXoq9aFuFcb5eCtqXit+JzmxQ4cBTkHAWlb6dmv5roOuFaL4tPN70
         GXfWJAnWZG9pKe+d9jEw07ch4HdQ97iH6V+tXV2NzJgW4/80ugG4dyGwk38xMBQLW3/i
         XUzdoAisCx1FNoIoFvJjijR58eyGYFOzxlupdFRIOF/c07/Eq1oRU4DKXp9n06l6V4ei
         4EaI125OemHYoAq//IDrXS0SO7meTjwFQ8g26MnAQlJ2ohfMdq+BSbeKx03rKEUbTIGt
         U9k3x7QLwmlnHVe4R4GXs3YuUGw/Rh7zVdTI3KoGKphDCGeMoRi4Bayg91DIIhZj0e88
         9gpQ==
X-Gm-Message-State: AGi0PubXyjtLXfOznN+pBoSGK0jeIfPaKX/zToW0lmH6nduZEcVFkEFM
        TiG64bZKCOpjJgoGEQcno9etn5jQ
X-Google-Smtp-Source: APiQypJkXI1PxZgnykhVQg58MBjQhfE0a4cwOsb/pP+A2uu56lQo4VHdOxRCHr9AWqAChQpzYdPYMQ==
X-Received: by 2002:a05:620a:c8c:: with SMTP id q12mr22839640qki.74.1588008326266;
        Mon, 27 Apr 2020 10:25:26 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:a88f:52f9:794e:3c1? ([2601:282:803:7700:a88f:52f9:794e:3c1])
        by smtp.googlemail.com with ESMTPSA id z18sm10979686qti.47.2020.04.27.10.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:25:25 -0700 (PDT)
Subject: Re: Suspicious RCU usage in bpf_ipv4_fib_lookup
To:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>
References: <CACAyw98u-tGR_cZYT5paGhXRneU5pfrGdxJx+ktZYNKFVBstUg@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <549a3793-16ec-cf59-19a0-70073414b3cb@gmail.com>
Date:   Mon, 27 Apr 2020 11:25:24 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACAyw98u-tGR_cZYT5paGhXRneU5pfrGdxJx+ktZYNKFVBstUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/20 11:02 AM, Lorenz Bauer wrote:
> This happens on today's bpf-next. There is a comment in bpf_ipv4_fib_lookup:
> 
>     /* xdp and cls_bpf programs are run in RCU-bh so
>     * rcu_read_lock_bh is not needed here
>     */
> 
> Maybe this is not the case for BPF_PROG_TEST_RUN?

Looking at the code I believe that is the problem.
