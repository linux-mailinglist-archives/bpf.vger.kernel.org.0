Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E970917983A
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgCDSop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:44:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 13:44:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id i9so3354341wml.4
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=McYCjFd7DNHcc98fHYBjU5qExu0x6OSshDp3fc3A0zc=;
        b=FSyk0RNDcJgmtsUCb5U3SP0sB3JM7GBEhNfl/HKWYonQ92L1E5AgCodzJTjDIS0lZQ
         iDTBH/Ozz1R+wL1OEZaX7dDMKzwjND4A7r4AJsxeYy5UxbF8rDU0yri2C0fraZbVLFGp
         2EPwzUp9CcVrzBsGO7IE+y/kEbmZcKMUJznNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=McYCjFd7DNHcc98fHYBjU5qExu0x6OSshDp3fc3A0zc=;
        b=enRSH5478a2VTDKCjCDeHXogQ2gkyStlEXKbBx6ihTtB6lb6eSYPu9R8BpJNqjCbel
         J8J0gAzbmSJnKefb8DH8oYfqJpAFCbbReWzXuDNKNdmOqRzznwSb7RY6P5cWbwuabc5e
         //IcQgT+9CtComuYADSl9RHC1245CglxWP2AqvgByResmrLXx8DZ9+I8CU65mgo9WwPg
         Rb4Few6F+Wr7nnaTusCFb4MPuQDomziUjhkty7q2+gkYtuT7/tTPeP4F3GBTZV8DfdaU
         8iXrga4eLUIMNW5pteI2gX/2DyiF0EvnFa3JfhkXRXEwUmHmHF6sIhWFMDzVXAgbL4cG
         X13Q==
X-Gm-Message-State: ANhLgQ16nw9bRuRAk/b2gERS18hWMTZQtqp5h7Rv5OJANuRZ66/3MLSD
        hKUnCoueEOd3MW9SDafyKvz1Tg==
X-Google-Smtp-Source: ADFU+vvZqJ7orqfIUz6zCACqQsDhFoNWWvxIGDk+ionaaED7Zge9hIRJH3EBO1ViFWFT9WeNMdMwMg==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr4786974wmj.186.1583347483522;
        Wed, 04 Mar 2020 10:44:43 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id d63sm5340119wmd.44.2020.03.04.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:44:42 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 19:44:41 +0100
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Refactor trampoline update code
Message-ID: <20200304184441.GA25392@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
 <20200304154747.23506-2-kpsingh@chromium.org>
 <cb54c137-6d8e-b4e5-bd17-e0a05368c3eb@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb54c137-6d8e-b4e5-bd17-e0a05368c3eb@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04-Mär 19:37, Daniel Borkmann wrote:
> On 3/4/20 4:47 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > As we need to introduce a third type of attachment for trampolines, the
> > flattened signature of arch_prepare_bpf_trampoline gets even more
> > complicated.
> > 
> > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > use bpf_tramp_progs to simplify the addition and accounting for new
> > attachment types.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> [...]
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index c498f0fffb40..9f7e0328a644 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >   	struct bpf_struct_ops_value *uvalue, *kvalue;
> >   	const struct btf_member *member;
> >   	const struct btf_type *t = st_ops->type;
> > +	struct bpf_tramp_progs *tprogs = NULL;
> >   	void *udata, *kdata;
> >   	int prog_fd, err = 0;
> >   	void *image;
> > @@ -425,10 +426,18 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >   			goto reset_unlock;
> >   		}
> > +		tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
> > +		if (!tprogs) {
> > +			err = -ENOMEM;
> > +			goto reset_unlock;
> > +		}
> > +
> 
> Looking over the code again, I'm quite certain that here's a memleak
> since the kcalloc() is done in the for_each_member() loop in the ops
> update but then going out of scope and in the exit path we only kfree
> the last tprogs.

You're right, nice catch. Fixing it.

- KP

> 
> > +		tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
> > +		tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
> >   		err = arch_prepare_bpf_trampoline(image,
> >   						  st_map->image + PAGE_SIZE,
> >   						  &st_ops->func_models[i], 0,
> > -						  &prog, 1, NULL, 0, NULL);
> > +						  tprogs, NULL);
> >   		if (err < 0)
> >   			goto reset_unlock;
> > @@ -469,6 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >   	memset(uvalue, 0, map->value_size);
> >   	memset(kvalue, 0, map->value_size);
> >   unlock:
> > +	kfree(tprogs);
> >   	mutex_unlock(&st_map->lock);
> >   	return err;
> >   }
