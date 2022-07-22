Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B497157E826
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiGVUPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVUPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 16:15:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A16475;
        Fri, 22 Jul 2022 13:15:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so7086024edc.4;
        Fri, 22 Jul 2022 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=8j0f8kcDZKNlClj0tfXDBIvaZa8cH3iU8GMAMU1+gOA=;
        b=q6qoXTr6dfiDJ0nyok8qUoXLu2ys9+yRIy9fRN3v3yq0eKGqjwpaOOYNBafQO+usLo
         fVJ7FwTywsy+RYGwnRLnZUuVHhVc2wLR5NsE3OB2PNUYT9GmOLNKPA+/xNTUHF7X2yYg
         evJjMVBDJHlUugF5xntkXgYbqkTIPFF3CzyhBleq/yUfdJpeF/t4ob84o2nl2v6Ote2d
         D2iILOFx6RYsywwSvRYVqbS1gsgOZrPsb9Ie+2ddLV8DDQToBgtgK+p+aOolqyfPd+u9
         cfWNaj2MYz3/lySlO7GW5ngsbRaxbLupOXk2qtJA1m8dah8SjJFravZNN7+Nzt6690nr
         lSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=8j0f8kcDZKNlClj0tfXDBIvaZa8cH3iU8GMAMU1+gOA=;
        b=pjwcg7u5N9mn7ASAfy3NyExqNZbK7i99xD/HXdI7sd8SP+PBLiY9FazJLqps+w/vRb
         g1eMq3i6CdZCdYTtqJmjqmEzCJ55HjuyfuZHg0L5+VscdG7IFjYn2P6F9F7BZ8o9Epm4
         p+zN4pd4iXbI8yly3a8O5j1AbmCMZvzUHpEGHJ2pYqofBi9QjoEmbGNcZfR3YtmGjsFy
         1y4/q4Q+W2yMUrcyvZrQIVG7JD/W7MU22oDyAmJvfodiqoX6cpMj4njlh6/Y67uuvG6X
         dHue/IE0rgyWNflf7buEmo0Ux3V2iBGgE93hiZfinG4zNGiMpivbu/4IrkYUP7xn3Kmh
         AKmQ==
X-Gm-Message-State: AJIora9ibLIcurYlIiVM4xWkKXTmcy4T+/kQnrcgqPRzyZCBgBI1GBFY
        /3yjj5ahCf/7m+lnC7MCQm4=
X-Google-Smtp-Source: AGRyM1skF55kV2PsDCz/VqH97+SGixBfyJouwQcU6lPMdag6XwQLdiZUaABv7ZwcjkVsxTY5xSQpJQ==
X-Received: by 2002:a05:6402:1117:b0:43b:c965:549e with SMTP id u23-20020a056402111700b0043bc965549emr1493693edv.366.1658520913332;
        Fri, 22 Jul 2022 13:15:13 -0700 (PDT)
Received: from krava ([83.240.63.177])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7dcc7000000b0043a83f77b59sm3008685edu.48.2022.07.22.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:15:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 22 Jul 2022 22:15:11 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YtsFT1yFtb7UW2Xu@krava>
References: <20220721111430.416305-1-lee@kernel.org>
 <Ytk+/npvvDGg9pBP@krava>
 <Ytk/jT+zyNZpafgn@google.com>
 <YtlDPYQWDcORbP0o@krava>
 <fbc98bb0-a2d6-a450-e6fc-878701e5906d@fb.com>
 <Ytm92NYx4SyKN4Nm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytm92NYx4SyKN4Nm@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 09:58:00PM +0100, Lee Jones wrote:
> On Thu, 21 Jul 2022, Yonghong Song wrote:
> 
> > 
> > 
> > On 7/21/22 5:14 AM, Jiri Olsa wrote:
> > > On Thu, Jul 21, 2022 at 12:59:09PM +0100, Lee Jones wrote:
> > > > On Thu, 21 Jul 2022, Jiri Olsa wrote:
> > > > 
> > > > > On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
> > > > > > The documentation for find_pid() clearly states:
> > > 
> > > typo find_vpid
> > > 
> > > > > > 
> > > > > >    "Must be called with the tasklist_lock or rcu_read_lock() held."
> > > > > > 
> > > > > > Presently we do neither.
> > > 
> > > just curious, did you see crash related to this or you just spot that
> > > 
> > > > > > 
> > > > > > In an ideal world we would wrap the in-lined call to find_vpid() along
> > > > > > with get_pid_task() in the suggested rcu_read_lock() and have done.
> > > > > > However, looking at get_pid_task()'s internals, it already does that
> > > > > > independently, so this would lead to deadlock.
> > > > > 
> > > > > hm, we can have nested rcu_read_lock calls, right?
> > > > 
> > > > I assumed not, but that might be an oversight on my part.
> > 
> > From kernel documentation, nested rcu_read_lock is allowed.
> > https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html
> > 
> > RCU's grace-period guarantee allows updaters to wait for the completion of
> > all pre-existing RCU read-side critical sections. An RCU read-side critical
> > section begins with the marker rcu_read_lock() and ends with the marker
> > rcu_read_unlock(). These markers may be nested, and RCU treats a nested set
> > as one big RCU read-side critical section. Production-quality
> > implementations of rcu_read_lock() and rcu_read_unlock() are extremely
> > lightweight, and in fact have exactly zero overhead in Linux kernels built
> > for production use with CONFIG_PREEMPT=n.
> > 
> > > > 
> > > > Would that be your preference?
> > > 
> > > seems simpler than calling get/put for ppid
> > 
> > The current implementation seems okay since we can hide
> > rcu_read_lock() inside find_get_pid(). We can also avoid
> > nested rcu_read_lock(), which is although allowed but
> > not pretty.
> 
> Right, this was my thinking.
> 
> Happy to go with whatever you guys decide though.
> 
> Make the call and I'll rework, or not.

ok, I can live with the current version ;-) could you please resend
with fixed changelog?

thanks,
jirka
