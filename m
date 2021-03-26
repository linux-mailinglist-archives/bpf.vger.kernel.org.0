Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3128834A6A2
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 12:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZLux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 07:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhCZLue (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 07:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616759433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYXpnr6q5SVVBqz2jz7zk7foKLG3DhehiVbSaUBTtAM=;
        b=Vk4s2XN4MmG9N1X/hbMQ5XYSjqs9gby+Bm/wVxq1pwQr+7JnfSyGar6et4z6hRwiI9aRqS
        mQbfq9hRaKvMZt1X17G/BIQo+DZhKUcS36qdnG9jBW9FaL/fF6CvQsof1j0RpWQac7kElx
        6fEBtQ7cSJcJegCaIRktxFCYVQJRZS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-ZhVAA6DhOS-740lzfMgWpQ-1; Fri, 26 Mar 2021 07:50:29 -0400
X-MC-Unique: ZhVAA6DhOS-740lzfMgWpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3784C87A826;
        Fri, 26 Mar 2021 11:50:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 609D619D7C;
        Fri, 26 Mar 2021 11:50:26 +0000 (UTC)
Date:   Fri, 26 Mar 2021 12:50:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH bpf-next v4] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
Message-ID: <YF3KgXsWjqOpM/dA@krava>
References: <20210323055146.3334476-1-yhs@fb.com>
 <3a2052e8-eb4b-fefc-4a0c-ad051b5609d0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2052e8-eb4b-fefc-4a0c-ad051b5609d0@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 25, 2021 at 06:38:54PM -0700, Alexei Starovoitov wrote:
> On 3/22/21 10:51 PM, Yonghong Song wrote:
> > Jiri Olsa reported a bug ([1]) in kernel where cgroup local
> > storage pointer may be NULL in bpf_get_local_storage() helper.
> > There are two issues uncovered by this bug:
> >    (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
> >         before prog run,
> >    (2). due to change from preempt_disable to migrate_disable,
> >         preemption is possible and percpu storage might be overwritten
> >         by other tasks.
> > 
> > This issue (1) is fixed in [2]. This patch tried to address issue (2).
> > The following shows how things can go wrong:
> >    task 1:   bpf_cgroup_storage_set() for percpu local storage
> >           preemption happens
> >    task 2:   bpf_cgroup_storage_set() for percpu local storage
> >           preemption happens
> >    task 1:   run bpf program
> > 
> > task 1 will effectively use the percpu local storage setting by task 2
> > which will be either NULL or incorrect ones.
> > 
> > Instead of just one common local storage per cpu, this patch fixed
> > the issue by permitting 8 local storages per cpu and each local
> > storage is identified by a task_struct pointer. This way, we
> > allow at most 8 nested preemption between bpf_cgroup_storage_set()
> > and bpf_cgroup_storage_unset(). The percpu local storage slot
> > is released (calling bpf_cgroup_storage_unset()) by the same task
> > after bpf program finished running.
> > bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
> > interface.
> > 
> > The patch is tested on top of [2] with reproducer in [1].
> > Without this patch, kernel will emit error in 2-3 minutes.
> > With this patch, after one hour, still no error.
> > 
> >   [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
> >   [2] https://lore.kernel.org/bpf/20210309185028.3763817-1-yhs@fb.com
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Applied to bpf-next. Thanks
> 

sorry for late reply, FWIW I dont see the issue anymore with the patch

thanks,
jirka

