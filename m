Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963F688497
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBBQh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBBQh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 11:37:27 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327506ACAD;
        Thu,  2 Feb 2023 08:37:25 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id c2so2470856qtw.5;
        Thu, 02 Feb 2023 08:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZcMZtX0EcrnZWfZ+/LmjRHXr0PdSo84F4e6GziTzqs=;
        b=AWYqHcgzqxO5ebANia5/Cn+jymsaZwCR+XGYIYTIm+fv05IEEOu21WimGHbwKDvY21
         mDWsntjP2q9TTfG/zRvXA0nbhGCvUO4oEkBpRcVStc1eqntYFDmcVRFfaA14SHnjNigC
         k+8hkmAzLa1EOjXUchgQu8YRA3bAlffUSevxcjfln2tpO5bbRfoX7bE2FBic/Bt/VzwR
         oW700eJHzFHvmOoUYNdyiWGbGhWn0OHyw5lIO0BVvsjJuA7Gg7tpgTWbQzQWvI+8w17v
         AsdIILEY9DeaC+GqiXjRy9eK0I/hx5ITAcbXHx7YJ3y41cfb36VuC+5uUUrEMzvXudd7
         5gnw==
X-Gm-Message-State: AO0yUKX95BWsn07igF/zUYIUebDK0Fx8EaoVlIDnIWovkU2itkWFocUk
        ECAmfj8OymEuFr/HHKJSSjP09f29zLjGiOeB
X-Google-Smtp-Source: AK7set+6zZfInvXTRPt5yHf2IXZGocXEZhfejwDDyitrpBIueWTVph19PgBMcotaifge5E1TFUlZJw==
X-Received: by 2002:a05:622a:211:b0:3b6:4175:5308 with SMTP id b17-20020a05622a021100b003b641755308mr4540882qtx.54.1675355844119;
        Thu, 02 Feb 2023 08:37:24 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b4-20020a378004000000b0070736988c10sm14532379qkd.110.2023.02.02.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:37:23 -0800 (PST)
Date:   Thu, 2 Feb 2023 10:37:20 -0600
From:   David Vernet <void@manifault.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v3] Documentation/bpf: Document API stability
 expectations for kfuncs
Message-ID: <Y9vmwDzb0jhjpEyk@maniforge>
References: <20230201174449.94650-1-toke@redhat.com>
 <Y9tJY3ayftdowRVS@maniforge>
 <875yckth7n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yckth7n.fsf@toke.dk>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 12:55:08PM +0100, Toke Høiland-Jørgensen wrote:
> David Vernet <void@manifault.com> writes:
> 
> > On Wed, Feb 01, 2023 at 06:44:48PM +0100, Toke Høiland-Jørgensen wrote:
> >> Following up on the discussion at the BPF office hours (and subsequent
> >> discussion), this patch adds a description of API stability expectations
> >> for kfuncs. The goal here is to manage user expectations about what kind of
> >> stability can be expected for kfuncs exposed by the kernel.
> >> 
> >> Since the traditional BPF helpers are basically considered frozen at this
> >> point, kfuncs will be the way all new functionality will be exposed to BPF
> >> going forward. This makes it important to document their stability
> >> guarantees, especially since the perception up until now has been that
> >> kfuncs should always be considered "unstable" in the sense of "may go away
> >> or change at any time". Which in turn makes some users reluctant to use
> >> them because they don't want to rely on functionality that may be removed
> >> in future kernel versions.
> >> 
> >> This patch adds a section to the kfuncs documentation outlining how we as a
> >> community think about kfunc stability. The description is a bit vague and
> >> wishy-washy at times, but since there does not seem to be consensus to
> >> commit to any kind of hard stability guarantees at this point, I feat this
> >> is the best we can do.
> >> 
> >> I put this topic on the agenda again for tomorrow's office hours, but
> >> wanted to send this out ahead of time, to give people a chance to read it
> >> and think about whether it makes sense or if there's a better approach.
> >> 
> >> Previous discussion:
> >> https://lore.kernel.org/r/20230117212731.442859-1-toke@redhat.com
> >
> > Again, thanks a lot for writing this down and getting a real / tangible
> > conversation started.
> 
> You're welcome! Just a few quick notes on one or two points below, we
> can continue the discussion at the office hours:

Hey Toke,

Sounds good, I just read over your notes / points and am happy to
discuss more in office hours as you suggested. Just wanted to give you a
heads up well that just I sent out a proposal which you can read in [0].

[0]: https://lore.kernel.org/all/20230202163056.658641-1-void@manifault.com/

I know it's short notice (sorry about that, did my best to get it all
ready as soon as possible before office hours), but if you happen to
have time to read over it before we meet that would be great. If not, no
worries, I can just tell you the gist of what I'm proposing when we talk
in office hours in half an hour.

Thanks,
David
