Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08122158652
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 00:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJX6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 18:58:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34380 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgBJX6Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 18:58:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so4746789pgi.1;
        Mon, 10 Feb 2020 15:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ecnhmrr02m11MvZnIXErIkdoBlLHRUvHjs8abNILLO4=;
        b=jOicBg6EVEA407Dzu72yN32aWil8i3M++pQe4B4Sp01hvwUBjlj+UraPSgjeowRfxc
         rsP6/Uk29lQkTdHGqrXXn3FhLRAzIewCf0ffaNclqCdCr02XenqCGo9sso48IEvOO3o2
         bQN6tZ4aXIa2VcroBSM1EDy+vaPP02vJ94BkyiI670QBKsqnIZh2L3aAdLCBepLX97N7
         ygYACF8NElDDT86eBFxb+TWV1Hz8pRvBF0SWI8o7uElFYKppW0sqr15VZXZmt4SH4OoQ
         USqIiWOONNXB3U15+8lwLynYGMVbc+CNqvOnh7hiDgobgXCmetJhVHs3Yq+Y7v6g8TCk
         RcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ecnhmrr02m11MvZnIXErIkdoBlLHRUvHjs8abNILLO4=;
        b=Vf+RhLthEwC9iFL+0Dy6FiO6NACSBCRw8Zy+rxH2jzZ7nNGaxPa35aYpwthl102n7/
         I9j2NGit3H5Ie/sR3pl1N0Zl7HYqx7PaDK3EnxmnHEY6DswbsgkAUuGBmOjKaudvp7zg
         aCMthvssDEcJhqutJNmH0VsV1sbUStYnGDWlL+ib09lMANPvxAC6MnKJXqwM6GfySSGs
         jAz/YBZ+isQuD8yVwbMyW6npNM/dQLLfaTxkZyAEhZbTIkXK1wmfHqXfP299KyE2gYoY
         +3KCymBz6t/au+RHdEe4IZ0oEqqMiI2lXJJdqbanRIC3hDNT50em/6YqkYLENzL5+Zvd
         rmnw==
X-Gm-Message-State: APjAAAW3Zff77w6qn/XInZkFlYiNREcv4giDc7Z8DUyEB3Q9J5MZoDba
        KbzYTNKHFE29/OM21Pi+o48=
X-Google-Smtp-Source: APXvYqzRirYSTB3POFj4Z/KykVthxZd07mfAm+G4rwNkAKJwEVP3dAGHbCKNNSmlXaEhandiR5Dezw==
X-Received: by 2002:a63:e755:: with SMTP id j21mr4135479pgk.330.1581379095567;
        Mon, 10 Feb 2020 15:58:15 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::2:685c])
        by smtp.gmail.com with ESMTPSA id n2sm1189089pgn.71.2020.02.10.15.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 15:58:14 -0800 (PST)
Date:   Mon, 10 Feb 2020 15:58:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: lsm: Introduce types for eBPF
 based LSM
Message-ID: <20200210235811.pbzvlok6rin7lctd@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123152440.28956-4-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 07:24:33AM -0800, KP Singh wrote:
> +
> +static const struct bpf_func_proto *get_bpf_func_proto(
> +	enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	switch (func_id) {
> +	case BPF_FUNC_map_lookup_elem:
> +		return &bpf_map_lookup_elem_proto;
> +	case BPF_FUNC_get_current_pid_tgid:
> +		return &bpf_get_current_pid_tgid_proto;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +const struct bpf_verifier_ops lsm_verifier_ops = {
> +	.get_func_proto = get_bpf_func_proto,
> +};

Why artificially limit it like this?
It will cause a lot of churn in the future. Like allowing map update and
delete, in addition to lookup, will be an obvious next step.
I think allowing tracing_func_proto() from the start is cleaner.
