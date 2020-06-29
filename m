Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4817F20E345
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgF2VMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 17:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbgF2S5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:43 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01DC031C5C
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 10:39:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so15999278qkn.11
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DkJLGr2YKRXiLLH1Q6VhLFiWB4wUGNH1QgmtPqjWno=;
        b=l6FSd0In6b81j2G/sx0DuCx5xKhUbQxcxyrd+0kzeLc94/5kWmMKfbfMrBn3vi2Q9h
         DkFbZkcwVJ+o+jMMR029YMk6aNikxvNaD09m2XnHzQZ7l0YlEs19fGJiPDxANFeSqWJ7
         +2u7L8aYmOZRrFS/rIXqYfToPbYAo2j3gfBYdYDofU/97+hHGkZHMd5EqsO4EeoEVN2W
         Myki9xAUIHt6oBTxIHmlOLKLhYBPP0wyrqoScJNDrVdFO006riG5zCysdYpoNrmdqUVb
         TM6EGmRl282UofMe65ue1qXHa3JAJEkA54gXwqT+8Z6WiowIjjX7jIt5mj26mUd8rlvR
         V3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DkJLGr2YKRXiLLH1Q6VhLFiWB4wUGNH1QgmtPqjWno=;
        b=Ob06xXEYJf8XCC10QpZOkR/BMT4Yl745gEWikkahwvk+akMCiYenlfdor2ofBpcqXW
         /xx6opb8sBLoZRqmIL860SCtCUDoCdOSLRUwA8Hjz+uEAX3wr5MqOdg34W1NObpR9CBt
         23DOqijPKL4yh9j1tBcsaXrH+9jata9bsuNMYfws7fz/pfsp+QLDpGiBHJVsW8ljn75r
         Sh+Xzx5oAVRqNgp4/t8VM0L3MxCskbyv6vc4v3SIiyo8HcxgUI5Ugqi8tvLIAWDEtN+l
         RVh02mWY6/vZK8QiE9BrkL72/EnrBvTSKnhfccShR5cU4mQN+iyptNWAvMzI0Yc7pkwa
         tVJQ==
X-Gm-Message-State: AOAM533fDsL9MieIkubfE9yKHDJoWN+aLfc8F9Xnal8uaN5tUwJsuIKC
        JyK8Kz/3p4Y3LJf5NsDcW4VkyqHwd7o3rQKEvgU=
X-Google-Smtp-Source: ABdhPJwQZhxdg+duMocMSg8BT6YjK70QxRpBI9s6U+uzy6ZOL/tM9rMUz7uNJC+8E2J2mxl6JzvVBrn3RBIRjKzLapY=
X-Received: by 2002:a37:7683:: with SMTP id r125mr13707956qkc.39.1593452391019;
 Mon, 29 Jun 2020 10:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <159344647797.836609.7781883615056725815.stgit@firesoul>
In-Reply-To: <159344647797.836609.7781883615056725815.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Jun 2020 10:39:39 -0700
Message-ID: <CAEf4BzavSVPQ4Gq3PvvckUhFOGVDHruuZQdnxb10PeO9mWifKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for getting
 number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 9:01 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> It can be practial to get the number of tests that test_progs
> contain.  This could for example be used to create a shell
> for-loop construct that runs the individual tests.
>
> Like:
>  for N in $(seq 1 $(./test_progs -c)); do
>    ./test_progs -n $N 2>&1 > result_test_${N}.log &
>  done ; wait
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  tools/testing/selftests/bpf/test_progs.c |   11 +++++++++++
>  tools/testing/selftests/bpf/test_progs.h |    1 +
>  2 files changed, 12 insertions(+)
>

[...]
