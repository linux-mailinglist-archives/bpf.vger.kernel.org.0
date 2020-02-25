Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6316EF08
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgBYTbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 14:31:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbgBYTbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 14:31:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so61454wrl.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlBxXO82SnjJ6YAbFFiOmvHTdiQt/bwkAdND6MM2qHM=;
        b=CWKAFxy9a32tMI17qQoLdEtkjjrlAcX9YJDmjUVVKSG4h9NutRtLDmYCLK2nFmHJwB
         NQFyAkimI5H97b5ALHt4fWJGRofXmtFQt6cKtyL09lVP/iJUDLu9RJEwzIJ0vNrRWR6E
         uhcMmxqbUpdl/rg78QZHMRqXH0qsvX4l+qhD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlBxXO82SnjJ6YAbFFiOmvHTdiQt/bwkAdND6MM2qHM=;
        b=oDMj9m3zzud26hZ64ehm/tXFg3oZ25OPBd/3aN8nRr0js9OdFfpCMd4r89fI9bU3Gk
         tUL1sMXNqf1Wr5zKnuuLmd4QHxc1Xon266R31oYG5MBQKm8959902E7I3QoDb8V/1ZNj
         zuhg3ki3Od8uJ8pHarOwf8HIsaIPtCQusIsm99kym2omwsW50Da24mRf06pxEAA5PflW
         q2u+5p65J2TzEsNjLNqaPfwON2gbCp5vboYKX2yabpDcHEF8MPScZgsLUAXXqx98+oom
         3tK+fraddpDqfeqQxwgGiEWnS4AgKMc1QHKTVgUmE03mr8YQKfQ6ShlWIxGyeuAZQYsV
         ARrg==
X-Gm-Message-State: APjAAAV8vNpzvCMINm29wGt4qRABUZMdRQlPbNaZdZRv5VZ0dm3E+kHJ
        2HL3bh6DnZkm/h39rNYo7FzxSA==
X-Google-Smtp-Source: APXvYqzz0xbe63IL/CAtvmuQXSgsaD0L9stv95M/mevMi1AFwc0CmqJCxfn5wOXcrgY82hZGANGWeQ==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr641380wrt.325.1582659070262;
        Tue, 25 Feb 2020 11:31:10 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id d76sm5569661wmd.39.2020.02.25.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:31:09 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 25 Feb 2020 20:31:08 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200225193108.GB22391@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <202002211946.A23A987@keescook>
 <20200223220833.wdhonzvven7payaw@ast-mbp>
 <c5c67ece-e5c1-9e8f-3a2b-60d8d002c894@schaufler-ca.com>
 <20200224171305.GA21886@chromium.org>
 <00c216e1-bcfd-b7b1-5444-2a2dfa69190b@schaufler-ca.com>
 <202002241136.C4F9F7DFF@keescook>
 <20200225054125.dttrc3fvllzu4mx5@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225054125.dttrc3fvllzu4mx5@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24-Feb 21:41, Alexei Starovoitov wrote:
> On Mon, Feb 24, 2020 at 01:41:19PM -0800, Kees Cook wrote:
> > 
> > But the LSM subsystem doesn't want special cases (Casey has worked very
> > hard to generalize everything there for stacking). It is really hard to
> > accept adding a new special case when there are still special cases yet
> > to be worked out even in the LSM code itself[2].
> > [2] Casey's work to generalize the LSM interfaces continues and it quite
> > complex:
> > https://lore.kernel.org/linux-security-module/20200214234203.7086-1-casey@schaufler-ca.com/
> 
> I think the key mistake we made is that we classified KRSI as LSM.
> LSM stacking, lsmblobs that the above set is trying to do are not necessary for KRSI.
> I don't see anything in LSM infra that KRSI can reuse.
> The only thing BPF needs is a function to attach to.
> It can be a nop function or any other.
> security_*() functions are interesting from that angle only.
> Hence I propose to reconsider what I was suggesting earlier.
> No changes to secruity/ directory.
> Attach to security_*() funcs via bpf trampoline.
> The key observation vs what I was saying earlier is KRSI and LSM are wrong names.
> I think "security" is also loaded word that should be avoided.
> I'm proposing to rename BPF_PROG_TYPE_LSM into BPF_PROG_TYPE_OVERRIDE_RETURN.

The BPF_PROG_TYPE_OVERRIDE_RETURN seems to be useful in general as
well and we have the implementation already figured out as a part of
the LSM work. I will split that bit into a separate series.

- KP

> 
> > So, unless James is going to take this over Casey's objections, the path
> > forward I see here is:
> > 
> > - land a "slow" KRSI (i.e. one that hooks every hook with a stub).
> > - optimize calling for all LSMs
> 
> I'm very much surprised how 'slow' KRSI is an option at all.
> 'slow' KRSI means that CONFIG_SECURITY_KRSI=y adds indirect calls to nop
> functions for every place in the kernel that calls security_*().
> This is not an acceptable overhead. Even w/o retpoline
> this is not something datacenter servers can use.
> 
> Another option is to do this:
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 64b19f050343..7887ce636fb1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -240,7 +240,7 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>         return kernel_load_data_str[id];
>  }
> 
> -#ifdef CONFIG_SECURITY
> +#if defined(CONFIG_SECURITY) || defined(CONFIG_BPF_OVERRIDE_RETURN)
> 
> Single line change to security.h and new file kernel/bpf/override_security.c
> that will look like:
> int security_binder_set_context_mgr(struct task_struct *mgr)
> {
>         return 0;
> }
> 
> int security_binder_transaction(struct task_struct *from,
>                                 struct task_struct *to)
> {
>         return 0;
> }
> Essentially it will provide BPF side with a set of nop functions.
> CONFIG_SECURITY is off. It may seem as a downside that it will force a choice
> on kernel users. Either they build the kernel with CONFIG_SECURITY and their
> choice of LSMs or build the kernel with CONFIG_BPF_OVERRIDE_RETURN and use
> BPF_PROG_TYPE_OVERRIDE_RETURN programs to enforce any kind of policy. I think
> it's a pro not a con.
