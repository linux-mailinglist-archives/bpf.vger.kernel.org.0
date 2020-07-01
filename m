Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16447210542
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGAHpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 03:45:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11EC061755
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 00:45:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so18726344edr.9
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=A6/wD5TOmbPrbVpYq666ibenBocLd+0FXv5RuujEH1I=;
        b=D1CRevDt9/d8zVypC6pHJANDd5sgEFK8q7/V3PlkQ3XYm8D7emKlOvPUz+Zw0OX+Nd
         K9Hl6xyWGQ6eSlfyMwKvc5nJr5KNFUyX1jimBQ8fqUHkxDGA+gccBij/W7S2GdIavlhv
         5moaYQ8PztsojTV1sFEkKcLr1cr7BSzIATqt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=A6/wD5TOmbPrbVpYq666ibenBocLd+0FXv5RuujEH1I=;
        b=Qz62mVkbPgMbdIqHoWZwzTMO+68FueWuAkOSdF2T4ISSp9ngmvGaXGN/LiQCgsuPN+
         IuMqSsBDZtwlXqmAMPpOM1XYEZTvWw7hHigLsAT9xPfhgmU8vj5vyti7bmUHbmIwL9f7
         +qJed2Wujx0hJhFt5TNfh6BhfZ2npx4BtdNJwL+3Lka6+iiuJPonbW+YK5kXRo9jzpk6
         g2E/gWhsfy+hEKO/mCvPiKM6pbDdKTQfKip7QMa1M/Mn4SvZaLPLuqQtMQUiHn1UERwX
         wdMTqTe74u5SC5gRIT1IjyOTmBhl+C6TcR5u2WeUQs+eP3rqwqUw6CIUsfrVWUxbfafW
         CoXw==
X-Gm-Message-State: AOAM530noJMG1i78dFsYRbm7ih0xfPASZE8gWh4AShtWWhB8QSIEYteM
        nlgRmBpTG1kM1SdwCJ+2gQDmjA==
X-Google-Smtp-Source: ABdhPJwSrEyxYrHVCZRvG4my6oExIWUFsLIFxKmP0b+vLCficclBhHc+zbdsUe+L7ZYK1jnzrH5/Xg==
X-Received: by 2002:aa7:dd10:: with SMTP id i16mr25324750edv.227.1593589503025;
        Wed, 01 Jul 2020 00:45:03 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id g21sm5549271edu.2.2020.07.01.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:45:02 -0700 (PDT)
References: <20200629095630.7933-1-lmb@cloudflare.com> <CAADnVQ+VN6nUCQC51nByeKa+uHG=O-GyzeEpWQgJ8OP815RB2A@mail.gmail.com> <878sg4mmlm.fsf@cloudflare.com> <CAADnVQJ6ZxCwik7r-XW3bt+h5p37Uq3WL=Rm=yChbkHQSHaj-w@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
In-reply-to: <CAADnVQJ6ZxCwik7r-XW3bt+h5p37Uq3WL=Rm=yChbkHQSHaj-w@mail.gmail.com>
Date:   Wed, 01 Jul 2020 09:45:01 +0200
Message-ID: <877dvnn0g2.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 08:42 PM CEST, Alexei Starovoitov wrote:
> On Tue, Jun 30, 2020 at 11:31 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> But if you decide to keep my patchset in 'bpf', then can you please also
>> apply the today's fixup [1]? Or I can resend with correct subject prefix
>> tomorrow.
>
> Already did.
> I found it in patchworks, but not in my mailbox.
> Please cc myself and Daniel in the future.
> vger can be unreliable some times.

Noted. Will do from now on.
