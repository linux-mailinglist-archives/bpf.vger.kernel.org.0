Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E421F1725D5
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 19:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgB0SBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 13:01:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38017 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0SBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 13:01:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so86206pgn.5
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2020 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tS80FFrulMAq3gFVJqPVLBSeriNjSm0l+etnYqy/xvo=;
        b=u4mwCN/Yt1fSjnN1SqaP7vk9R2hPmv30FfXWZiVGQgr9ZzA5so5vGH2weHCffgCAPv
         qJV5ZPEmvwnmRjU6OoO7tHdO3zQLWU/lDcwWVkNeFwcfD7BL7FADDisUoIUOEMK4mx5w
         fed/SyJaAqXVo5VevxxBXR2bJiWPEKBPnW8xGRCqBO6y2vtCS+COb/NZIZ9FkjZJ1bMa
         meI180XcdNVavo92xdh12xDleWZQjR+ekE/22UX+tuZSJ5d4QcrTgSP+O97q8bNORO4a
         6p/lPOgjeKXnGRiEdYPJ32WdqNRZc49NnWf1l1pCd6ANqQKnUJb6H9BBgYX5W1fDAfvl
         Es5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tS80FFrulMAq3gFVJqPVLBSeriNjSm0l+etnYqy/xvo=;
        b=C7CGbMv5j2ylTP8oyaI6eh+mGaqqOuESd1BqZoWLELI3rq7VoBxyxNayhl/67kceLJ
         dTiVkYiqYkYm9Jrgu5pS+lc96u9lgYJLY5dQACwdUhqQa0I68DSxhnzR6sEQNE2w0YCA
         HtjcmeAxSDRiQ1hjaHz3k0fx7dPnCWSRbTFqEiMTpIjG12lTTl/CxTUd3yJ8GY6V3jq1
         cpV5axKh+HlXfk/F/7V12q36Nnc56gav0wwcwbEv/2aA3wf9XVD8x3MoBX4zRSc4Njdt
         wbXxIgtvtDqMVJl0fls/QXBmAG4Mb7Dg9XB3cy7g9dJ10O03uGDMcN4c5UZoA9sLO7KN
         /Q/A==
X-Gm-Message-State: APjAAAWutwrSWP3vkT4v0+QW/tY0btjY4AcZ47iYKGk0UWzGRIc598Pb
        TGXAX8WfPB7TP8mk5lBplxZ28Q==
X-Google-Smtp-Source: APXvYqxnGMxQ1dQTPtPaSyutxhvH2otm2BVCmrlVRBjR6EyHvqS+oIE9woDzJZl/x+a5R5TYIHybng==
X-Received: by 2002:a63:4281:: with SMTP id p123mr493974pga.371.1582826463395;
        Thu, 27 Feb 2020 10:01:03 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id h13sm7158777pjc.9.2020.02.27.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:01:02 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:01:02 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        osandov@fb.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
References: <20200227023253.3445221-1-rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227023253.3445221-1-rdna@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/26, Andrey Ignatov wrote:
> drgn is a debugger that reads kernel memory and uses DWARF to get types
> and symbols. See [1], [2] and [3] for more details on drgn.
> 
> Since drgn operates on kernel memory it has access to kernel internals
> that user space doesn't. It allows to get extended info about various
> kernel data structures.
> 
> Introduce bpf.py drgn script to list BPF programs and maps and their
> properties unavailable to user space via kernel API.
Any reason this is not pushed to https://github.com/osandov/drgn/ ?
I have a bunch of networking helpers for drgn as well, but I was
thinking about contributing them to the drgn github, not the kernel.
IMO, seems like a better place to consolidate all drgn stuff.
