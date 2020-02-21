Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD80167C66
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 12:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBULpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 06:45:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37850 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBULpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 06:45:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so1458763wme.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DXupJrMnAWhan34uKDapRUBUNT/taBkKhFiSrKwkXL4=;
        b=bmN4wS6ug4tZIN6CmBEpm3KsNOT0qg+Ky+IASGb9XYwTAZoP54XjF/fDF1rcvl88KN
         6ROSbXOmz9HDxO0an5o7/vD05vhM+CPCteyI9eAgdntihtdQchQ/Ae9fY7N8yLpl4hHJ
         93Wj+F3I1yfKvMQHFpR1/BKVkP8GGQB1IBDlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DXupJrMnAWhan34uKDapRUBUNT/taBkKhFiSrKwkXL4=;
        b=HKQtKdL/YmwMQs644rl3UkjvX73juCxlOEYTZzZrTMal4hEKCnmq5t5TyansZNmjY6
         ZPVEQOEdTpPC1V7GmE9XbqT/W/H28RKCklU67hah/019FBYLnAor2d59wN2O028oa/3B
         gLMCmphfvyk2mj3uiyBvMVMLV2Gamhb/h3HsQJH8Rty+aSKq3TNUOOTV4iG0+dG5f20p
         NrY8gMwqlXnFu5PidccLKqvRurRymKaUWihYoXQSDNahNMZju3LK/jR69d0nhkeR/ScY
         KSLbem0ItFYYyq5PShHQQgT0AfPuGbwEuj7PSde9Dp2yLsnAz0ZKHnxRcb/hyWa3RwQr
         wrww==
X-Gm-Message-State: APjAAAWiAvohAI9eb9mpmmbMJno+pnsM8TJ/99flh1QK5fvCAWBsKEV4
        1R70fzlDO3lw5BnmCtQfLn0FUg==
X-Google-Smtp-Source: APXvYqx5RSeRzqmz9bTDHGFwL+wWF+Q6B9vUZec/Wf66az4Xzyek9i8FfG2/QboGFgV60Lo7nNl5jQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3379938wmk.172.1582285500797;
        Fri, 21 Feb 2020 03:45:00 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id v16sm3336675wml.11.2020.02.21.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 03:45:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 21 Feb 2020 12:44:58 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200221114458.GA56944@google.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20-Feb 15:49, Casey Schaufler wrote:
> On 2/20/2020 9:52 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> Sorry about the heavy list pruning - the original set
> blows thunderbird up.
> 
> >
> > The BPF LSM programs are implemented as fexit trampolines to avoid the
> > overhead of retpolines. These programs cannot be attached to security_*
> > wrappers as there are quite a few security_* functions that do more than
> > just calling the LSM callbacks.
> >
> > This was discussed on the lists in:
> >
> >   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266
> >
> > Adding a NOP callback after all the static LSM callbacks are called has
> > the following benefits:
> >
> > - The BPF programs run at the right stage of the security_* wrappers.
> > - They run after all the static LSM hooks allowed the operation,
> >   therefore cannot allow an action that was already denied.
> 
> I still say that the special call-out to BPF is unnecessary.
> I remain unconvinced by the arguments. You aren't doing anything
> so special that the general mechanism won't work.

The existing mechanism would work functionally, but the cost of an
indirect call for all the hooks, even those that are completely unused
is not really acceptable for KRSI’s use cases. It’s easy to avoid and
I do think that what we’re doing here (with hooks being defined at
runtime) has significant functional differences from existing LSMs.

- KP

> 
> >
> > There are some hooks which do not call call_int_hooks or
> > call_void_hooks. It's not possible to call the bpf_lsm_* functions
> > without checking if there is BPF LSM program attached to these hooks.
> > This is added further in a subsequent patch. For now, these hooks are
> > marked as NO_BPF (i.e. attachment of BPF programs is not possible).
> >

[...]
