Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECA3FB0C3
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhH3FSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 01:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhH3FSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 01:18:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF64C061575;
        Sun, 29 Aug 2021 22:17:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x16so6194660pll.2;
        Sun, 29 Aug 2021 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHHSVUC33opd0Qk264rfSpwjz98z3QDj3NJ2fck9jK8=;
        b=ruFk5CbiFcmUIQIrV5qw73AqFPMx3QkbPlt3zAEW1e5XM6sllr8w3G28RQMdhsxuBW
         h+mb3ituDPXuhZ296jtkzXZyR4QAj+s7WoxDRFUkSzr7IO4SxFjcoKjH40+DpX/18cuo
         oZYbBwL5WM8VkXFZiOwJ2h+s2CEIRN/oX/KzYu/EBQ9r0iw1uOYh4iLjYuBWV8PU9YTr
         klTMw+zI+dOAmkIqgOOygsgze7qCEjZanGDZ1XDj7swi5nMsBKi2ro+76XAlOTLw0Mbf
         FJY6/6YEbOp11ZKeyk3K/3fdvbVLi5Ug9I0CXXnJTJ7EpSygyIo7BhUzqqDaKpIK2SxW
         vDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHHSVUC33opd0Qk264rfSpwjz98z3QDj3NJ2fck9jK8=;
        b=Cbnkq5v3jMK8GHM1HbsWfxN2G68qVft1tLODSrkmfRAEvIXv6uJDKdKHyfkfE3pcmK
         M9z+/uyZW+VTz0kK2all7mJZIAfniL46X2dnqBqwndV2OnBGX+t+pSlosC2IZvSmS4mU
         d6yYNddEfw5iXDEsIDWgur/pFLCbu6qfwTpde0+VzKA2iD2iX9TwTDW0czqlPVr210iV
         o+8aMQnuxEEwYe2XADzkmPS2Sjw7+2dWa9I5aof0Hm5JLVWFzAFsW0wtHHC+ZBSTuIdg
         jRZtHIWL13rBmA4e+wFcyXedJubmbyIXjO8iHFQ380NaPlO7e4GR6Ous4rHs7+HJXEII
         6nGA==
X-Gm-Message-State: AOAM533lQ14cyPQuxWeU38kGAPdDmdijzJ72CTNyTGoAkkE74W5amvxH
        ZkJ0y0lX15HM2g22lx1dDZ8=
X-Google-Smtp-Source: ABdhPJwKTedFwFlET8b1JDZJlQKbw55j+YsvPv9Q/fvHJFHKyEdzM5Fg3bAd/4SUr+hroX+2l9D34g==
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id w2-20020a170902a702b029012baa0fd553mr20215149plq.3.1630300642337;
        Sun, 29 Aug 2021 22:17:22 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id y5sm15488462pgs.27.2021.08.29.22.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 22:17:21 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:47:19 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
Message-ID: <20210830051719.xfl4llkiarmvk4r2@apollo.localdomain>
References: <20210826133913.627361-1-memxor@gmail.com>
 <20210826133913.627361-2-memxor@gmail.com>
 <20210830042346.GA26321@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830042346.GA26321@mail.hallyn.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 09:53:46AM IST, Serge E. Hallyn wrote:
> On Thu, Aug 26, 2021 at 07:09:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> > +static struct bpf_local_storage_data *
> > +file_storage_lookup(struct file *file, struct bpf_map *map, bool cacheit_lockit)
> > +{
> > +	struct bpf_local_storage *file_storage;
> > +	struct bpf_local_storage_map *smap;
> > +	struct bpf_storage_blob *bsb;
> > +
> > +	bsb = bpf_file(file);
> > +	if (!bsb)
> > +		return NULL;
> > +
> > +	file_storage = rcu_dereference(bsb->storage);
>
> It's possible that I am (and the docs are) behind the times, or (very likely)
> I'm missing something else, but Documentation/RCU/whatisRCU.rst says that
> rcu_dereference result is only valid within a rcu read-side critical section.
>
> Here it doesn't seem like you're in a rcu_read_unlock at all.  Will the
> callers (bpf_map_ops->map_lookup_elem) be called that way?
>

This function will either be called from the BPF program, which is run under RCU
protection, or from bpf_map_* bpf command, which also has rcu_read_lock
protection (see map_copy_value, bpf_map_update_value in kernel/bpf/syscall.c
called from map_lookup_elem, map_update_elem) when calling the map_ops.

> > +	if (!file_storage)
> > +		return NULL;
> > +
> > +	smap = (struct bpf_local_storage_map *)map;
> > +	return bpf_local_storage_lookup(file_storage, smap, cacheit_lockit);
> > +}
> > +
> > +void bpf_file_storage_free(struct file *file)
> > +{
> > +	struct bpf_local_storage *local_storage;
> > +	struct bpf_local_storage_elem *selem;
> > +	bool free_file_storage = false;
> > +	struct bpf_storage_blob *bsb;
> > +	struct hlist_node *n;
> > +
> > +	bsb = bpf_file(file);
> > +	if (!bsb)
> > +		return;
> > +
> > +	rcu_read_lock();
> > +
> > +	local_storage = rcu_dereference(bsb->storage);
>
> Here you've called rcu_read_lock, but you use the result of it,
> 'local_storage', after dropping the rcu_read_unlock, which whatisRCU.rst
> explicitly calls out as a bug.
>

It is only used without rcu_read_lock protection in one place, in the branch
that depends on 'free_file_storage', at which point we are responsible for
freeing the local_storage after unlinking the last storage element from its
list and resetting the owner.

> [...]

--
Kartikeya
