Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3367D14A45D
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgA0NBI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:01:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0NBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:01:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so6134602lfl.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=56+J5cIzO/HEZ3g1vNJEnErUzmgJTqUDxjwesQXEzIo=;
        b=ttIP3YTpDOShSPys4IVs5UuwfuFi3dWkUO7TodM8qjGCE1nYcl3cFaV2URAFD+JOo2
         pOnpBdqcT7+5fBg5NheUdlj5iWxB8c6eF2ugBLLlfk2jEct69UEZ6wHi3ZOVevX7UH/m
         u3HS+Oi/U3b+GthBxBzAmjLt8o+vB17r+y8lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=56+J5cIzO/HEZ3g1vNJEnErUzmgJTqUDxjwesQXEzIo=;
        b=HNv44MQU0vKLyR3Wwb32zlWWNs2KGCURRfNlCRqA6icNyFxN+1iA/NeVcvkWv0fSr9
         AVHiqJni57EOEYt6ONvwd0pxMRXHRtN9UHTXNefxuZ7lzMl+gJ7nAEvNYjfEnjhRH7dk
         WlZk02Lc4kux2vLW3gBBTDMCCTLFWOzbOD7dHx6XJT+zhq4BUN4yiukz0iVoZeP/jMg5
         ec/R5PjrpglUpU/qFvzhrtj9aRVtTNop+t8m9zJYfVJAoZLDJ8myPTyOBOxqcLX9CVG5
         lrPUwjT0Yo86VnCUv7WiwVoTVawBmrEbdnZcCQtVIOal4CalDzbXOv4RK5Da+sxrhXZh
         Oo0g==
X-Gm-Message-State: APjAAAW4k53DKXVjRmEcJUWR3xpJTgbreh56hp9Qem4K+xpuoBFfm9Z/
        kLhWwTg26/lBp/6z+Jt52JZj5e6Iu2mojg==
X-Google-Smtp-Source: APXvYqyMOJ6I4Hs85xIkf63tqrdh/5Q9W43SnodSZMkHn+4BfKchKgqmW5fkqZPgflReNenTVB5NtA==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr8011595lfj.27.1580130065573;
        Mon, 27 Jan 2020 05:01:05 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i1sm8099259lji.71.2020.01.27.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:01:05 -0800 (PST)
References: <20200127125534.137492-1-jakub@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v5 00/12] Extend SOCKMAP to store listening sockets
In-reply-to: <20200127125534.137492-1-jakub@cloudflare.com>
Date:   Mon, 27 Jan 2020 14:01:03 +0100
Message-ID: <87eevlcauo.fsf@cloudflare.com>
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

Should be: "Patches 1 & 2 *had* conflicts". Sorry for the typo :-)

[...]
