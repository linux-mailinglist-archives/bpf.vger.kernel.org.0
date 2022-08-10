Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096358EB8C
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiHJLw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 07:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHJLw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 07:52:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5407D1E8;
        Wed, 10 Aug 2022 04:52:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qn6so15439355ejc.11;
        Wed, 10 Aug 2022 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=ehno/SjxBI23HPBparcnIDPiUCpTkSu5X80BvIMFKVs=;
        b=EG+vAH2ovWKE8dUB1I3gxGtmRTefbhUMPfD2QnW+ZMDtSPGq0hmMCaR8J2kaowjyyy
         7bpjrjHw0CQiDLVH9pOtec9X858DHB7Pumo9jSdL9JiYga5Gtt8MDRORLiD9Mv3zazTK
         x+s2k4D1dtEaROhfaxvTZ/0ODJIv4PUTYzQpZSsVFQJ937pZzvM041h/Y38hzE7jam2Z
         sN3jVYydNK8biazB6zThVkdFu52gCjXq+/F75xVOIEILl1rlz2wBlcswZbd84NvowXB5
         oU6ldZtV+2t7UwPySAHL9/waZzSn7RYltvJi3hYrZHbFk2PAyvOezxPz6zkjzyI4YqNA
         d7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=ehno/SjxBI23HPBparcnIDPiUCpTkSu5X80BvIMFKVs=;
        b=4r7FgB3G4hzOX6KMXmrT2d/aZHF16QXd+fElKsuby+Ky7+9mZnmRpoUPPmXRuYH0Rr
         RDReJetHN4/uHbBr+EgRlnly4/d/NSHtRLOySKap3Q0BzHrc9kLCgiaFB7sVGH9d/ANZ
         pgKx4ugzUf+9HzqNYz4HtrVgieEkh7TyBch6C3NiIG/XmgIqDn6IY8nhat7S4+iOkZBf
         IdziiMnG3k7KRJ/IjnQCWdyHWvaFSZvumI4tMN2oGWC2rcd0zli0eQqZJ2GNV/riiGz5
         vTmrkN5z7yezI+dnDLWJO1U5dWFoBvE6j6CP8t3Ti4V6HAVOviUTeVDlsck6cyZryZVe
         kz1g==
X-Gm-Message-State: ACgBeo1ImqbprAtMNbRecck1G+rzwIM8owQXbdlccGH0m+w7++QnrKf5
        8ObdN3nbIwBmUyeR616PGio=
X-Google-Smtp-Source: AA6agR4tgPVhyEVOEBsk7z7+7Ios8R9LycYiju7Ppa8IcfRbIHsYToqlJdrnvX80fb8r4k/gbwPMMA==
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id wu7-20020a170906eec700b00733189fb07amr672600ejb.230.1660132374742;
        Wed, 10 Aug 2022 04:52:54 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090694c400b007313a25e56esm2214287ejy.29.2022.08.10.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:52:54 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 10 Aug 2022 13:52:50 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YvOcEqGf6KgmUmmp@krava>
References: <20220803134821.425334-1-lee@kernel.org>
 <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
 <YvIDmku4us2SSBKu@google.com>
 <CAADnVQ+5eq3qQTgHH6nDdVM-n1i4TWkZ35Ou8TDMi3MqGzm63w@mail.gmail.com>
 <YvOQhTUD1x6W0ozO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvOQhTUD1x6W0ozO@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 12:03:33PM +0100, Lee Jones wrote:
> On Tue, 09 Aug 2022, Alexei Starovoitov wrote:
> 
> > On Mon, Aug 8, 2022 at 11:50 PM Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Thu, 04 Aug 2022, Alexei Starovoitov wrote:
> > >
> > > > On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > The documentation for find_pid() clearly states:
> > > > >
> > > > >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > > > >
> > > > > Presently we do neither.
> > > > >
> > > > > Let's use find_get_pid() which searches for the vpid, then takes a
> > > > > reference to it preventing early free, all within the safety of
> > > > > rcu_read_lock().  Once we have our reference we can safely make use of
> > > > > it up until the point it is put.
> > > > >
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > > > Cc: Song Liu <song@kernel.org>
> > > > > Cc: Yonghong Song <yhs@fb.com>
> > > > > Cc: KP Singh <kpsingh@kernel.org>
> > > > > Cc: Stanislav Fomichev <sdf@google.com>
> > > > > Cc: Hao Luo <haoluo@google.com>
> > > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > Cc: bpf@vger.kernel.org
> > > > > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >
> > > > > v1 => v2:
> > > > >   * Commit log update - no code differences
> > > > >
> > > > >  kernel/bpf/syscall.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > index 83c7136c5788d..c20cff30581c4 100644
> > > > > --- a/kernel/bpf/syscall.c
> > > > > +++ b/kernel/bpf/syscall.c
> > > > > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > > > >         const struct perf_event *event;
> > > > >         struct task_struct *task;
> > > > >         struct file *file;
> > > > > +       struct pid *ppid;
> > > > >         int err;
> > > > >
> > > > >         if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > > > > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > > > >         if (attr->task_fd_query.flags != 0)
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > > > > +       ppid = find_get_pid(pid);
> > > > > +       task = get_pid_task(ppid, PIDTYPE_PID);
> > > > > +       put_pid(ppid);
> > > >
> > > > rcu_read_lock/unlock around this line
> > > > would be a cheaper and faster alternative than pid's
> > > > refcount inc/dec.
> > >
> > > This was already discussed here:
> > >
> > > https://lore.kernel.org/all/YtsFT1yFtb7UW2Xu@krava/
> > 
> > Since several people thought about rcu_read_lock instead of your
> > approach it means that it's preferred.
> > Sooner or later somebody will send a patch to optimize
> > refcnt into rcu_read_lock.
> > So let's avoid the churn and do it now.
> 
> I'm not wed to either approach.  Please discuss it with Yonghong and
> Jiri and I'll do whatever is agreed upon.

yea, I thought using rcu_read_lock would be better, but I did not
have strong feelings against doing the pid's refcount inc/dec when
Yonghong supported that.. now with Alexei it's 2 against 1 in favour
of using rcu_read_lock ;-)

jirka
