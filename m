Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D419379C59
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 03:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEKB71 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 21:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEKB70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 21:59:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF4C061574;
        Mon, 10 May 2021 18:58:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t193so2105062pgb.4;
        Mon, 10 May 2021 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfb3brAO8XWJfdgkhGGRuD9V8q0qAhMWf2N+lXUGAI8=;
        b=NbWz1+nGHPYracVAfIfg8DVYmx8frzrXmjl7OwCUWppwDAPNrGRwweWiTJlhAoVd8B
         ccfp0+cj2DrBE6xZEMkA+0D0CTlAzsxQKmPOoHXTX6QbmCOj9Uw93Ge/MUUP/bAONb7O
         yXd7QV/0iG2RL/7A54r1GZkuJZD4QF2dXrz/l4l7rPnq2bTGGw6TiC6iUxVpZSqwyb+q
         LsaejNnsF46mY8gZOCzg7NOztTOsr42xnyzDw7CnudznmEOp+Om+I+W+mSnvm1MtaMrv
         62uNcNQSSKkS4rvrPc9jhFFVw2f4WE+OWh+v6/j0+tN6Ff5p4s9mmSFfX73JhC7jMPLB
         pwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfb3brAO8XWJfdgkhGGRuD9V8q0qAhMWf2N+lXUGAI8=;
        b=e8LF9d4Ja//iwuRLWBPyLU/TyXCSZgooB7OgsrUFW+q7eP8I/a/+85g+qzFnK1CNm9
         74UCm87PhlLWf5wbMj2LXqUFRA6OwwM/RKsFWDNn6o8CFQxbmg6apZ4a7igRccN8bQj9
         jryPYh7XdR7mdUU0qHxAGCjABRz9PH1hD5K5RvPgfoBSHtw94FhWECrsUKE6lojcMDIH
         I5xWVwpuFXt3gBgZGOSO7AHgx+FVAELYx+YHb7kxJmFIEtvObpmOjS9Cr0qcVqZ8SUT+
         r4JpZ5owPIwmYoCelDOkCxgK/1VHkk+T+XgBl26LJJ3Q+sE7PJ5k4YS2Iedh5ztuwtvC
         atRQ==
X-Gm-Message-State: AOAM531wN2kvDwSfaZ28b63fdulFhHOZ71n968J70/odhenCZcEtCIue
        KMEgm43b+QfzC7DTFhi7IUw=
X-Google-Smtp-Source: ABdhPJy+FkCyEwc2ACzhstx3MCytDXs66PVFPvh1IdgEKPXKuEHYPeEHOki6dJL5unrDdx6BuaH2Og==
X-Received: by 2002:a63:515d:: with SMTP id r29mr28482386pgl.422.1620698299896;
        Mon, 10 May 2021 18:58:19 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:bba4])
        by smtp.gmail.com with ESMTPSA id mn22sm604056pjb.24.2021.05.10.18.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 18:58:19 -0700 (PDT)
Date:   Mon, 10 May 2021 18:58:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux.dev, bpf@vger.kernel.org,
        YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 12/12] seccomp-ebpf: support task
 storage from BPF-LSM, defaulting to group leader
Message-ID: <20210511015814.5sr37y4ogf5cr7c5@ast-mbp.dhcp.thefacebook.com>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <db41ad3924d01374d08984d20ad6678f91b82cde.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db41ad3924d01374d08984d20ad6678f91b82cde.1620499942.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 12:22:49PM -0500, YiFei Zhu wrote:
> +
> +BPF_CALL_4(bpf_task_storage_get_default_leader, struct bpf_map *, map,
> +	   struct task_struct *, task, void *, value, u64, flags)
> +{
> +	if (!task)
> +		task = current->group_leader;

Did you actually need it to be group_leader or current is enough?
If so loading BTF is not necessary.
You could have exposed it bpf_get_current_task_btf() and passed its
return value into bpf_task_storage_get.

On the other side loading BTF can be relaxed to unpriv,
but doing current->group_leader deref will make it priv only anyway.
