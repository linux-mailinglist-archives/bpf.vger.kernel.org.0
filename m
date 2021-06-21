Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DB3AE9CF
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUNPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFUNPG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 09:15:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628EC061574
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 06:12:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bm25so15342819qkb.0
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xWhYn+WlRjUC4zBpI8Caq+8Ybn6U/+lv6sESG3EDnWs=;
        b=nqB6Z6inHjjL5CNAPJqdZi2pyH9lVvLfPVPG4hm4CQJOUzamZEv6eUkensbb0GXKOw
         50t7dRlFw7ELvg0fHppa4H4csxBCiyrvfVOuYRnRA2uI7142Uj8DfVI5mrTpc7u6yquc
         j+AUUBsLQOojw2lJ3nDzgmfWvgIZAAtwI1L1kcF3rzVwXsoHLsawnfKnaw6timmP7jM3
         qS69iS1xwfAuyaxNTNiWqRWs1IH0Bmjz2VobXf9cq2btsKn36gc+SShpwPUyCwjFJy7k
         eo8CEmWhV/nt4J7AZyQSguspgQbh/6cj4xux10COpyBTVS9mLk2Y2uL5gg1HNkVtgjHA
         KOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xWhYn+WlRjUC4zBpI8Caq+8Ybn6U/+lv6sESG3EDnWs=;
        b=pIZkXCGms2s1CCw5eltHVOfP/KNjmkCAQhAcnppRrH++Y9GaXgBRu6KdX25gPfANN2
         hlGrzcSEDl3zImzaUXqnL7ZO4eK1cexT6OG4QpOhIt2S/ZpXbj+N6SeLhp7qbhEI6ut2
         EdI8YMaLcm1j9Wjml+eQmyLb4rJz8gOoCHYj+eFQvqATJxXk5MDjExyB6u6pYhie9pQR
         82a4Q2mW+YA67o4lusnx5WSJLkqGfpeoe+dR60ktb3TPR+1b838TI8boOPTSpIo2JrmU
         RMdYJr9HTACodftms1MmB+jtw/LQhx/0CKJDlAYvgH1Z/drqbVl7XoM9TMEU8Wpbeegh
         j6JA==
X-Gm-Message-State: AOAM530dFd/fD7fQGTINDD+ef2KePtRScAjr+40jsCGOqa6IRZI1WZVu
        7hb8H4DC2ipSI+D1Kylr+Yci8Eu4JiMvKKke9k6OF9L4wAw=
X-Google-Smtp-Source: ABdhPJyToAO97dQSkt8P4F82Z2+/S82NzY5h8lUmdQpbj2n76i7meQdgXLqy2IhOcf8svwOd87UKAhLWC7AZHeJKnZQ=
X-Received: by 2002:a25:2d18:: with SMTP id t24mr2192776ybt.158.1624281170949;
 Mon, 21 Jun 2021 06:12:50 -0700 (PDT)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Mon, 21 Jun 2021 21:12:15 +0800
Message-ID: <CAHb-xau6SrWN0eU1XB=jjvae3YxnAK0VsU08R0bH4bbRqo4aBA@mail.gmail.com>
Subject: Create inner maps dynamically from ebpf kernel prog program
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

My ebpf program is attched to kprobe/vfs_read, my use case is to store
information of each file (i.e., inode) of each process by using
map-in-map (e.g., outer map is a hash map where key is pid, value is a
inner map where key is inode, value is some stateful information I
want to store.
Thus I need to create a new inner map for a new coming inode.

I know there exists local storage for task/inode, however, limited to
my kernel version (4.1x), those local storage cannot be used.

I tried two methods:
1. dynamically create a new inner in user-land ebpf program by
following this tutorial:
https://github.com/torvalds/linux/blob/master/samples/bpf/test_map_in_map_user.c
Then insert the new inner map into the outer map.
The limitation of this method:
It requires ebpf kernel program send a message to user-land program to
create a newly inner map.
And ebpf kernel programs might access the map before user-land program
finishes the job.

2. Thus, i prefer the second method: dynamically create inner maps in
the kernel ebpf program.
According to the discussion in the following thread, it seems that it
can be done by calling bpf_map_update_elem():
https://lore.kernel.org/bpf/878sdlpv92.fsf@toke.dk/T/#e9bac624324ffd3efb0c9f600426306e3a40ec
7b5
> Creating a new map for map_in_map from bpf prog can be implemented.
> bpf_map_update_elem() is doing memory allocation for map elements. In such a case calling
> this helper on map_in_map can, in theory, create a new inner map and insert it into the outer map.

However, when I call method to create a new inner, it return the error:
64: (bf) r2 = r10
65: (07) r2 += -144
66: (bf) r3 = r10
67: (07) r3 += -176
; bpf_map_update_elem(&outer, &ino, &new_inner, BPF_ANY);
68: (18) r1 = 0xffff8dfb7399e400
70: (b7) r4 = 0
71: (85) call bpf_map_update_elem#2
cannot pass map_type 13 into func bpf_map_update_elem#2

new_inner is a structure of inner hashmap.

Any suggestions?
Thanks,
Rainkin
