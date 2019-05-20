Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44F23F5B
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfETRrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 13:47:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35589 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfETRrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 13:47:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so11963774ljb.2
        for <bpf@vger.kernel.org>; Mon, 20 May 2019 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyTJpL1BHuLaRSZ/rqTHzZ6DUBpP18SUBBGFoSOcny8=;
        b=VPFkY6gj7gSGB44JP3rghEPVFn0qxYW1fhck6vlUNuRAJhluunmdfBBhBfwl2371Vk
         huv1F3Dw8vLeWOfmekvea8cVzyAU8Cjj4cULRbUqDyVH3R8g7g7/YIGNpfk4S3EfVvLz
         RuZ7GcvXQXGYtXWjG3Ed2MjnAGpX+1387014T9OSTGzfkMZKOafKVjXqAbM7v+c0iM5J
         ys6jiZnNpF+70vPGf/gCo0RCcVBnhWXs9Ct7xcWKeKMQ5PrEyh5Jqu7hWThr8xKngKZ3
         TDcZQ/yCGIUHvILSh3T1YDrASkkX9aWJ+5FwqQ4H0DD3xuVeCQ8rYMTp2YWeWIvxeY5c
         9m6Q==
X-Gm-Message-State: APjAAAVPpLo3q/Mbt+F6mLGJt+JFHlUwVBRPzk74u2ckq8NxLQ7oNg9u
        3bwLWmnis/EZX0ZD8AFSwgAChcmKV2Y0RMObRBeaGw==
X-Google-Smtp-Source: APXvYqy3i8sepeeUBj1Jv7zSFSVFg/7+UvwGF5/OmKEWwccotlb1NKSO/wXNPyHb3czO1wZpyt4wnf9VlD16bxAiD00=
X-Received: by 2002:a2e:4701:: with SMTP id u1mr32888626lja.38.1558374423668;
 Mon, 20 May 2019 10:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190518004639.20648-1-mcroce@redhat.com>
In-Reply-To: <20190518004639.20648-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 20 May 2019 19:46:27 +0200
Message-ID: <CAGnkfhxt=nq-JV+D5Rrquvn8BVOjHswEJmuVVZE78p9HvAg9qQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] samples/bpf: fix test_lru_dist build
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 18, 2019 at 2:46 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Fix the following error by removing a duplicate struct definition:
>

Hi all,

I forget to send a cover letter for this series, but basically what I
wanted to say is that while patches 1-3 are very straightforward,
patches 4-5 are a bit rough and I accept suggstions to make a cleaner
work.

Regards,
-- 
Matteo Croce
per aspera ad upstream
