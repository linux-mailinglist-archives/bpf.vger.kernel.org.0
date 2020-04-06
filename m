Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DA19F4A8
	for <lists+bpf@lfdr.de>; Mon,  6 Apr 2020 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgDFLej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Apr 2020 07:34:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727181AbgDFLej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Apr 2020 07:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586172878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Td0qmJhFGaHA2Wqtu8EGlxM4UuCh1EuR6xJZTZL2Dmw=;
        b=IdjfUNIOw6sGMt+SkOmImJTHhonuI6ae2x09KdPlbFgyXM59SMHSiXdBCXvph/CwsBN/5u
        IJ1u62au8UPYYF1rPocgzxMsmLdSjKpzuOTeOP+nj96veOllu0POlQq/ZSLyoT1xwXWhxJ
        R+P/iFBM+E/DofY5t6NrkCeE8WbumNU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-qqBcevhbMAWCA3JXLXW8Ew-1; Mon, 06 Apr 2020 07:34:36 -0400
X-MC-Unique: qqBcevhbMAWCA3JXLXW8Ew-1
Received: by mail-lf1-f70.google.com with SMTP id a14so5135061lfl.15
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2020 04:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Td0qmJhFGaHA2Wqtu8EGlxM4UuCh1EuR6xJZTZL2Dmw=;
        b=uN/DvRvrVnmYxsCX7c5vTW6dSvcaaRKBoVgwLC03MTNpgAMPAMnJrLluZu7gIrebxS
         xqDOvU743jisGS9AvcehK6xA25HB6gVKfX9Vc7YPQjZX9s0h5odk3xKoiaGPPZRqk8Z+
         +9nYeGsiM+54j/z5o4CQA+GhkSakcts7tpjjCzIZvcUiXGff6l34VidNsFeF/QmoQzw+
         sgY1b384CsR8uyPlFWe+5rlgY4GiYJRjhendVSz9YM/vDh8zVkkrdJzBzJ4gJPvKcDyD
         sPTMnIaoXHBUM8iv2CoqAv2Jr16BA/9hgt/qYESZxGU3RG2VbS8sWu3AH8hoTSZUuxnH
         0LGw==
X-Gm-Message-State: AGi0PuZ5/TqzuennZeQbsiR1kghu0J9tre9tQG55jqs+ydst3Hbby9Uw
        rbHQIKtIGe/biqDcu+Xxn/ySosxaEK99PPOz3ksiPphm4ial4h7BU/a6nSZmHa6d5GWM6W2So+1
        ayDg90hTlE2kR
X-Received: by 2002:a19:f017:: with SMTP id p23mr13145397lfc.150.1586172874695;
        Mon, 06 Apr 2020 04:34:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIXFMnI97HPZDz//xcACckcDYI38kbDNaDdqnMNj0HO9bAl1ps1kiIldxBXH0jO0Fs4Kw+SKw==
X-Received: by 2002:a19:f017:: with SMTP id p23mr13145385lfc.150.1586172874514;
        Mon, 06 Apr 2020 04:34:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i20sm9751915lja.17.2020.04.06.04.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:34:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0415D1804E7; Mon,  6 Apr 2020 13:34:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [RFC PATCH bpf-next 4/8] bpf: support GET_FD_BY_ID and GET_NEXT_ID for bpf_link
In-Reply-To: <20200404000948.3980903-5-andriin@fb.com>
References: <20200404000948.3980903-1-andriin@fb.com> <20200404000948.3980903-5-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Apr 2020 13:34:32 +0200
Message-ID: <87pnckc0fr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Add support to look up bpf_link by ID and iterate over all existing bpf_links
> in the system. GET_FD_BY_ID code handles not-yet-ready bpf_link by checking
> that its ID hasn't been set to non-zero value yet. Setting bpf_link's ID is
> done as the very last step in finalizing bpf_link, together with installing
> FD. This approach allows users of bpf_link in kernel code to not worry about
> races between user-space and kernel code that hasn't finished attaching and
> initializing bpf_link.
>
> Further, it's critical that BPF_LINK_GET_FD_BY_ID only ever allows to create
> bpf_link FD that's O_RDONLY. This is to protect processes owning bpf_link and
> thus allowed to perform modifications on them (like LINK_UPDATE), from other
> processes that got bpf_link ID from GET_NEXT_ID API. In the latter case, only
> querying bpf_link information (implemented later in the series) will be
> allowed.

I must admit I remain sceptical about this model of restricting access
without any of the regular override mechanisms (for instance, enforcing
read-only mode regardless of CAP_DAC_OVERRIDE in this series). Since you
keep saying there would be 'some' override mechanism, I think it would
be helpful if you could just include that so we can see the full
mechanism in context.

-Toke

