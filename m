Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C27166CC0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBUCSB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 21:18:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45102 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 21:18:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so376204pfg.12;
        Thu, 20 Feb 2020 18:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aInQ+bV7EjLbwOn5yuSwAB2aHiKLYjiz5SbjsgDviAY=;
        b=Y9/zM3RMZGOGTJSxfuAMkGqEyNBqNlCEzUVmFk3K84KZUXDsfCMepHCF58vstGFBKB
         y61eklmJ5eDxwqDpmi+ucrwJadzGnUCt8ZucXxbxoVjpupv48FwGegfMjBeKhijgIZKG
         HYR7CjCNFapmynIWoJ7n/jAPG+UjgfUOjuVuw9YGCySO5ohewwPom0UXT7eDvpD1cQ3O
         WpWPF8YRXW1KqKGyo/SnHRMZfmUJKYSGFUa86KbPQi42TuGu6evc/z6u6EKaVLrwi9Y7
         BXJnSBvX6iVJnYYt7c25N85IpClOo5QrwCJNSHaMqx02cm7ZLWxEo+BrQeKTa8CE3KB6
         WBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aInQ+bV7EjLbwOn5yuSwAB2aHiKLYjiz5SbjsgDviAY=;
        b=XTZ7sbjn03IY+qPuOw3XbeuijXmVoFZNeyyffF2XJcezc4OSWZC0Ng9VWNRQkUKsuF
         IxcGlOaIOCrOXmL0ceC4j2UF+oT474bJ1U6hB+vEC1GsnpgS79Qy8XV/Sn8QA5iO2y6R
         C0LzHtMt1mWKLkCwzEbksdwh75AR+4W0DKqpAfErriKlcdUsfIxDRQq/hNuNtxczn2oy
         UpEawEXNOQv4VmYmSaHwXh48ZmyE2QdHzO46Y4CAdwVrC+m5JKqhTixbn+husE5ehbff
         +e2Lix8B178tGw6BFmN9Kr26gwXO3+3BrxLE2AFBTjvl+isPTizYk7wtHXDhY622tqpM
         4xJA==
X-Gm-Message-State: APjAAAVtURvHre3Pd9ov0w4kSxAkv+NnB9MxRI2xERIcvDW8AiHrBk9a
        sGmaPrdqheskwEFdLX+9rks=
X-Google-Smtp-Source: APXvYqw7sbSpit71nmXnqudgKI725O3kLqAZxewMC1o2xGr1TWmrCEhJZzOoQ7ak89Bs5Y7hhh01pQ==
X-Received: by 2002:a63:650:: with SMTP id 77mr35068014pgg.102.1582251480255;
        Thu, 20 Feb 2020 18:18:00 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::5:f03d])
        by smtp.gmail.com with ESMTPSA id z4sm867510pfn.42.2020.02.20.18.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:17:59 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:17:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200221021755.3z7ifyyeh6seo3zs@ast-mbp>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-6-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175250.10795-6-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 06:52:47PM +0100, KP Singh wrote:
> +
> +	/* This is the first program to be attached to the LSM hook, the hook
> +	 * needs to be enabled.
> +	 */
> +	if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 1)
> +		err = bpf_lsm_set_enabled(prog->aux->attach_func_name, true);
>  out:
>  	mutex_unlock(&tr->mutex);
>  	return err;
> @@ -336,7 +348,11 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
>  	}
>  	hlist_del(&prog->aux->tramp_hlist);
>  	tr->progs_cnt[kind]--;
> -	err = bpf_trampoline_update(prog->aux->trampoline);
> +	err = bpf_trampoline_update(prog);
> +
> +	/* There are no more LSM programs, the hook should be disabled */
> +	if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 0)
> +		err = bpf_lsm_set_enabled(prog->aux->attach_func_name, false);

Overall looks good, but I don't think above logic works.
Consider lsm being attached, then fexit, then lsm detached, then fexit detached.
Both are kind==fexit and static_key stays enabled.
