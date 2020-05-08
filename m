Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7C1CB284
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHPGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEHPGu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 11:06:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D57C061A0C
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 08:06:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i13so8666900oie.9
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lvwnhFDd/cmhJNNKsmXNg+ehQ3GiN0fUJfWc+H/B0zs=;
        b=cy9hehPMKa+WJUe5ElMYlcn6E7fJ7v/lmPm06jhq7mFWxu1uGzJLIjKzkRwdMUPVOK
         ndRvtHdUQMNd77RI3X+ghp9kBKdDx7hE+TktwLN3HdtBNn86dSTJqvwMmpzDEga3Vip/
         w1J7aJbuN4oyxXziInOwMCNEpt4YEpPz/iIsXMJr47XXoQfcSs3vnN1SbMmkKxvrM9DB
         CvWDHNwhphRaPl0H8xYVuUK+zGjhIKx7cfVct+AdMVRg1Lp4fLK/LHYkKxviLZDf4I/4
         vVUalPMBoSUje9F64hUF6Px1YEu3XCc/yTWvOme/LGbw5Y6x8qruUA63wL1M02c6Sa0Z
         ebVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lvwnhFDd/cmhJNNKsmXNg+ehQ3GiN0fUJfWc+H/B0zs=;
        b=NCJKo9JMDHfBDCGZAmXJnBYyBhVCLuOOKZyacEyBha54nXhn2EX28nTDe4xpNWSiiV
         OurSGoeBkZZhOOG6J9FM0X6CzkSCID9O4H2yLv/7OnBRDirituKOdS9EvNS1B4HjqIDc
         Ryssn3wb/1X0xfc9fSmGv8ZnDliRQm61JaVLyPjlcq3hz5bg5xXu4Urqu3Hd/MbbeVUo
         HKDFSKER+fhzHHvbbudSF6otHqbSx2jyfet4bYNoCEN5ZSCVlBPW9S3J6t48GCqvucuF
         z7wR+/jzkZ6iA+JmILltIIrT6B6nnJF5zCKSv4vnId2LEoSTmNZg88PdPkrkpKOf+iuE
         7CBQ==
X-Gm-Message-State: AGi0Puaak8+qTYsXDwLpGqmT/y0An2HTkC1Ofq9JulnU43f0k2HMbuA0
        4bIQgrl0QlPeoPq4HQWMwW9xLIfCtOuBHEE4MQE=
X-Google-Smtp-Source: APiQypKhVh9OPMuVYZzwlNvPp+Oa57pFyZy9sEBJUHKQfQrZRGGifPdxAxIv0DudukFZ3KcV/HGA38+JZc/hY4U2bqA=
X-Received: by 2002:aca:fc45:: with SMTP id a66mr10871523oii.5.1588950408637;
 Fri, 08 May 2020 08:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <CACZqfqC038WbB-iO86xsvpSehgRLaua_uObbOSJgxfx5DnV5Ww@mail.gmail.com>
 <CACZqfqDijnE9s-Vw8nao9gJ4ewF5oc+YO5_-XOEhDB_OvDRdWw@mail.gmail.com>
In-Reply-To: <CACZqfqDijnE9s-Vw8nao9gJ4ewF5oc+YO5_-XOEhDB_OvDRdWw@mail.gmail.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Fri, 8 May 2020 11:06:35 -0400
Message-ID: <CACZqfqB_1waiutsW5qZPQbPRX4jRcPX380pQ1J7Az1+3YSPMBA@mail.gmail.com>
Subject: Re: spelling fix for bpf_perf_prog_read_value optval doc
To:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Very sorry for the extra emails. I've finished touching sysdig...

From 2804d3c0cfddb8e73f75ba4fae01f59918973658 Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Fri, 8 May 2020 11:01:01 -0400
Subject: [PATCH 4/5] spelling: identifier

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ad84678714b4..fc13ccb191c3e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1085,7 +1085,7 @@ union bpf_attr {
  * Description
  * Retrieve the realm or the route, that is to say the
  * **tclassid** field of the destination for the *skb*. The
- * indentifier retrieved is a user-provided tag, similar to the
+ * identifier retrieved is a user-provided tag, similar to the
  * one used with the net_cls cgroup (see description for
  * **bpf_get_cgroup_classid**\ () helper), but here this tag is
  * held by a route (a destination entry), not by a task.

From d863cdab79b1f5a16e2b160bb9d0690be4f6b33e Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Fri, 8 May 2020 11:01:47 -0400
Subject: [PATCH 5/5] spelling: separately

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fc13ccb191c3e..bf19da37147af 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3359,7 +3359,7 @@ struct bpf_xfrm_state {
  * provide backwards compatibility with existing SCHED_CLS and SCHED_ACT
  * programs.
  *
- * XDP is handled seprately, see XDP_*.
+ * XDP is handled separately, see XDP_*.
  */
 enum bpf_ret_code {
  BPF_OK = 0,

In case of whitespace damage, please see:
https://github.com/torvalds/linux/compare/master...jsoref:spelling-bpf.patch
