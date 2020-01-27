Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DC14A46E
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgA0NFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:05:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41211 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA0NFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:05:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so6116228lfp.8
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=cV3DBU5zIwSvjSC3uugvJ7qJ6byUG1P03d9feBBjhNY=;
        b=OdqOcuO1vfgcedmxIHCikjp7GzSAV6nfhvOpxZMhgSUwVZRKBeI3UBPbwb+Ocn32pV
         Z2GoqgMggaiij2aYR47x3OhMaAjigJY8sBsCVZFsfQLq8iGESdkouzCu9jrZ47wDSZST
         Alzv3GbsSQ/qwS4ukoIfciieFuq1AmoMpjXpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=cV3DBU5zIwSvjSC3uugvJ7qJ6byUG1P03d9feBBjhNY=;
        b=cn0pmZ88lI8iZvO41iL8e2PSPfg9Py/WHmH0C8FmCpOIdHemuuptyyntWmOKj4Zw5D
         1KpeLrcKLgHHt2n/HHMU1nJhYQyADWCQBwPAfQsgC1rsM4I1KK0G1JucfJJfD08LgJgK
         HWGgJq04XgitO+np/5OmVg7uFOPbI81Y2pvRxsl+omWgr0dI78eqG3kXvSkapZprPuEQ
         75a5xW7ApkTng78OczFOItCgH2sznQuQH9Rzv5cmKEsoUj3h5t2bEt0gtimGCr6JvbDZ
         6Zp7QIv41Aek7PXaPLB0TcJnyrTs156HeYG61RD76PUOlNo/HUk+S9DleQ/ZArQU3Qq/
         tSUQ==
X-Gm-Message-State: APjAAAXq6mF81cH/VyKSmvv7Hg7zO/Ag4gNWn2xxpItbi4V9firs4uc8
        8PYKQZbqOF1MT6v7ZutPrCNYfW6L8NyBVw==
X-Google-Smtp-Source: APXvYqyywebOR6ItZ4HzCAQ7awqLbCj9qnIelmZjLSX349f6NxC1ODKbnmZtbqdDMzmidNrY9yE3wQ==
X-Received: by 2002:a19:4855:: with SMTP id v82mr7742497lfa.197.1580130305156;
        Mon, 27 Jan 2020 05:05:05 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id x29sm10085250lfg.45.2020.01.27.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:05:04 -0800 (PST)
References: <20200127125534.137492-1-jakub@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v5 00/12] Extend SOCKMAP to store listening sockets
In-reply-to: <20200127125534.137492-1-jakub@cloudflare.com>
Date:   Mon, 27 Jan 2020 14:05:03 +0100
Message-ID: <87blqpcao0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 27, 2020 at 01:55 PM CET, Jakub Sitnicki wrote:
> Make SOCKMAP a generic collection for listening as well as established
> sockets. This lets us use SOCKMAP BPF maps with reuseport BPF programs.
>
> The biggest advantage of SOCKMAP over REUSEPORT_SOCKARRAY is that the
> former allows the socket can be in more than one map at the same time.
> However, until SOCKMAP gets extended to work with UDP, it is not a drop in
> replacement for REUSEPORT_SOCKARRAY.
>
> Having a BPF map type that can hold listening sockets, and can gracefully
> co-exist with reuseport BPF is important if, in the future, we want to have
> BPF programs that run at socket lookup time [0]. Cover letter for v1 of
> this series tells the full background story of how we got here [1].
>
> v5 is a rebase onto recent bpf-next. Patches 1 & 2 has conflicts. I carried
> over the Acks.

Well, this is embarassing.

Please don't apply. I have some uncomitted local changes. Will roll v6.
