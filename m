Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701429F913
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 00:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJ2X2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 19:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2X2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 19:28:12 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305BD20BED;
        Thu, 29 Oct 2020 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604014091;
        bh=ZGC+Xp6nyJqG7qQE4W73onxUN0sycaXuLyBzJX/PmHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pmYHMztfmCpO3ah+/yJRu1db0AsnD1WO6AhahE2I+BumtOhoxSIWNRpafkV5Q8Wx8
         c0q6g91/SD15ADY4HFR4BVXhRkBe4OVfD5qeMy1YHcRPed7jkkCilp9KScJgsRE8L6
         28L6TeGAbrBndY4vIgvJ4GwUY1UTHmC2dDsXVO40=
Received: by mail-lj1-f181.google.com with SMTP id 2so4908116ljj.13;
        Thu, 29 Oct 2020 16:28:11 -0700 (PDT)
X-Gm-Message-State: AOAM532Hc6D/GfpSkhM+j8m/uEDTGOBUqEF3PCsLZIsbvLYe0oUpy0yr
        C1ycP9whcniltiaOOOflFx0azLjsz4ElZ/p8/8A=
X-Google-Smtp-Source: ABdhPJxOGJLwtLYEFStmDIc3k+4w9x2xuYQZn/5sV0IRSs+f/rMDH16JY+DKvKX8LGuv7SN5GGwZXcQy+nh4+JDz1BE=
X-Received: by 2002:a2e:a0d4:: with SMTP id f20mr1241951ljm.350.1604014089320;
 Thu, 29 Oct 2020 16:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org> <20201027170317.2011119-2-kpsingh@chromium.org>
In-Reply-To: <20201027170317.2011119-2-kpsingh@chromium.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 29 Oct 2020 16:27:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6yFbWLGZwpCE4whUm_ncJG4Fr7kf75XeqYLRWG8PvnWQ@mail.gmail.com>
Message-ID: <CAPhsuW6yFbWLGZwpCE4whUm_ncJG4Fr7kf75XeqYLRWG8PvnWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 9:17 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Similar to bpf_local_storage for sockets and inodes add local storage
> for task_struct.
>
> The life-cycle of storage is managed with the life-cycle of the
> task_struct.  i.e. the storage is destroyed along with the owning task
> with a callback to the bpf_task_storage_free from the task_free LSM
> hook.

It looks like task local storage is tightly coupled to LSM. As we discussed,
it will be great to use task local storage in tracing programs. Would you
like to enable it from the beginning? Alternatively, I guess we can also do
follow-up patches.

>
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> the security blob which are now stackable and can co-exist with other
> LSMs.
>
> The userspace map operations can be done by using a pid fd as a key
> passed to the lookup, update and delete operations.

While testing task local storage, I noticed a limitation of pid fd:

/* Currently, the process identified by
 * @pid must be a thread-group leader. This restriction currently exists
 * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
 * be used with CLONE_THREAD) and pidfd polling (only supports thread group
 * leaders).
 */

This could be a problem for some use cases. How about we try to remove
this restriction (maybe with a new flag to pidfd_open) as part of this set?

Thanks,
Song

[...]
