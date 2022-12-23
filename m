Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38F654ED1
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiLWJva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 04:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLWJuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 04:50:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A0532C6
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 01:46:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f9so3003912pgf.7
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WKoLIABwo+u1Fq4H0zGMt0eyWpWpm9fvY8EwGWoFJ8=;
        b=hznX9A2Q4O7umlkcuwP22V2+yaWYzaVhXHCGVoJDcbTdnPhaXfufB+WsF5SKNB1Gvf
         SElthpxh2m024cwwq/LihYtLNZzWhJ7lpAMdvF7jPS3B9hQ+brf9uQw8DEqI8e+XStEL
         6bxNGOV6S/RDeNPEx0DU2jxzi77Oh/OT4uasI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WKoLIABwo+u1Fq4H0zGMt0eyWpWpm9fvY8EwGWoFJ8=;
        b=NsofqQZv2auDuHxAR9nSJ/qYchv6XUxTxAWPTdzTD4IE4AGkTpGJ7kp17RldJNvae/
         OJIIb1iewyBXGQzRiVoUmIY81HjCc/ZZbNTZTOuxlYnCOsmHUR2p+EYwhP/kRcIuGJRi
         ALeevXPDcqWwvlWems57zZCjmt234OH1C/FhtT50cu2u0hzEDOvvgviNGSVYLK2L4wks
         tviH/WLdnXZbkqy08+jaaGtLnapGBDQ91aOx57Cvvycb3bL4GiWvvgAsIKiXwqS4IGDX
         rLzb8x5Uk3rIx2S21nY6Q1MtujWCrm9KlFVab3nQ/mnCTemfQboGMhsSsimBn9zc1nBM
         Symw==
X-Gm-Message-State: AFqh2kpgNt9JHRDp0bSZR/RRXaqQlIaJjVi32JD9wDxzPWMFYTdLWicM
        He1cafHGdl60qM/X7BShzUw34Q==
X-Google-Smtp-Source: AMrXdXurnA6li5fBYOAoBCQZkq+oGa/9RAYZqfEs4ZHYxs++R0+I2qRWCOry1qeNOL2QYQ86+odRIg==
X-Received: by 2002:a05:6a00:3254:b0:579:6402:64ce with SMTP id bn20-20020a056a00325400b00579640264cemr24245725pfb.8.1671788757507;
        Fri, 23 Dec 2022 01:45:57 -0800 (PST)
Received: from ubuntu ([121.133.63.188])
        by smtp.gmail.com with ESMTPSA id v65-20020a622f44000000b00575d06e53edsm2163497pfv.149.2022.12.23.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 01:45:57 -0800 (PST)
Date:   Fri, 23 Dec 2022 01:45:51 -0800
From:   Hyunwoo Kim <v4bel@theori.io>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Kees Cook <kees@kernel.org>, keescook@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, v4bel@theori.io
Subject: Re: [report] OOB in bpf_load_prog() flow
Message-ID: <20221223094551.GA1439509@ubuntu>
References: <20221219135939.GA296131@ubuntu>
 <Y6C1SFEj9MOOnAnb@google.com>
 <20221220113718.GA1109523@ubuntu>
 <CAKH8qBuerUeU7M2x5cfjJUuSjNTZj84Hd5s+rLZ+h-XHG_a4GA@mail.gmail.com>
 <AA40C8DF-45F6-4BFB-8A2D-F4714B754479@kernel.org>
 <CAKH8qBukDoBYZh+qvGw_Q4iXd2D9YJoWV5+gzyaU01j5b0tFPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBukDoBYZh+qvGw_Q4iXd2D9YJoWV5+gzyaU01j5b0tFPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 20, 2022 at 01:03:47PM -0800, Stanislav Fomichev wrote:
> On Tue, Dec 20, 2022 at 11:08 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On December 20, 2022 9:32:51 AM PST, Stanislav Fomichev <sdf@google.com> wrote:
> > >On Tue, Dec 20, 2022 at 3:37 AM Hyunwoo Kim <v4bel@theori.io> wrote:
> > >>
> > >> On Mon, Dec 19, 2022 at 11:02:32AM -0800, sdf@google.com wrote:
> > >> > On 12/19, Hyunwoo Kim wrote:
> > >> > > Dear,
> > >> >
> > >> > > This slab-out-of-bounds occurs in the bpf_prog_load() flow:
> > >> > > https://syzkaller.appspot.com/text?tag=CrashLog&x=172e2510480000
> > >> >
> > >> > > I was able to trigger KASAN using this syz reproduce code:
> > [...]
> > >> >
> > >> > > IMHO, the root cause of this seems to be commit
> > >> > > ceb35b666d42c2e91b1f94aeca95bb5eb0943268.
> > >> >
> > >> > > Also, a user with permission to load a BPF program can use this OOB to
> > >> > > execute the desired code with kernel privileges.
> > >> >
> > >> > Let's CC Kees if you suspect the commit above. Maybe we can run
> > >> > with/without it to confirm?
> > >>
> > >> I built and tested each commit of 'kernel/bpf/verifier.c' that caused
> > >> OOB, but I couldn't find the commit that caused OOB.
> > >>
> > >> So, starting from upstream, I reversed commits one by one and
> > >> found the commit that triggers KASAN.
> > >>
> > >> As a result of testing, OOB is triggered from commit
> > >> 8fa590bf344816c925810331eea8387627bbeb40.
> > >>
> > >> However, this commit seems to be a kvm related patch,
> > >> not directly related to the bpf subsystem.
> > >>
> > >> IMHO, the cause of this seems to be one of these:
> > >> 1. I ran this KASAN test on a nested guest in L2. That is,
> > >> there is a problem with the kvm patch 8fa590bf34481.
> > >>
> > >> 2. Previously, the BPF subsystem had a patch that triggers KASAN,
> > >> and KASAN is induced when kvm is patched.
> > >>
> > >> 3. There was confusion in the .config I tested, so the wrong
> > >> patch was derived as a test result.
> > >>
> > >> I haven't been able to pinpoint what the root cause is yet.
> > >> So I didn't add a CC for 8fa590bf34481 commit.
> > >
> > >Thanks for the details! Even if this particular one is unrelated,
> > >there are a couple of reports which still somewhat look like they are
> > >related to commit ceb35b666d42 ("bpf/verifier: Use
> > >kmalloc_size_roundup() to match ksize() usage") ?
> > >
> > >https://lore.kernel.org/bpf/000000000000ab724705ee87e321@google.com/
> > >https://lore.kernel.org/bpf/000000000000269f9a05f02be9d8@google.com/
> >
> > I suspect something is hitting array_resize() that wasn't maximal-bucket-size allocated. Does reverting 38931d8989b5760b0bd17c9ec99e81986258e4cb make it go away?
> 
> Reverting makes it go away for at least one of them:
> https://lore.kernel.org/bpf/0000000000004bee2205f0484e1d@google.com/T/#m60dba18e94e01094a899ab7fe8d19aa1a3cf26fe
> 
> The second one didn't like my patch, I'm trying again now:
> https://lore.kernel.org/bpf/Y6Iipad5vz55tl2A@google.com/T/#m032bed8c3d47f33a9fccd660446beabce98ff5fe

I have found the root cause of this issue.

This happens when krealloc() in push_jmp_history() receives an allocation 
request with a size smaller than the existing slab object.
Based on the poc code I first reported, it occurs when cur->jmp_history 
of 64 bytes is krealloc()ed to 32 bytes.

When krealloc() is called with a smaller size than the previous one as an argument, 
krealloc() does not 'kfree&reallocate', but only resets the slab redzone based on the newly received size (if KASAN is activated).
That's why `ksize(dst)` in copy_array() afterward returns the actual allocation size of 64 bytes. 
However, KASAN recognizes memcpy(dst, src, 64) as OOB because the redzone is set after 32 bytes by krealloc().

In any case, since the actually allocated size of dst is 64 bytes, exploiting this is close to impossible.
However, it seems that copy_array() needs to be patched in the direction of not using ksize().


Regards,
Hyunwoo Kim
