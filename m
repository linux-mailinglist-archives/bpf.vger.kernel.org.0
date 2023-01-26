Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4C67D521
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjAZTLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 14:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjAZTLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 14:11:22 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63664530DA
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:11:21 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d3so2125444qte.8
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPC7prdPv0OHN7WMGWduIDlO0POg0o2A2WbqJmpehA8=;
        b=PwQyAN5HoEmY4yK9YC7IBVSy4/gGWPAJ/878JUdQ/aICHDiB3obt3/H1g7oKMpzg+c
         ptOtbjF25ZTroE/2+SlIfB5dRW5f7H/FHtUOnA2/q9JGIPeLyvle5Sq3u3c+J7KtN+FS
         YkhiU1S4qpiU3O8LSnQ3HTX4y/GeIRw29+HZrPmtSmyHlx4+8Q/Nd7yxXmpD4E5SpdT2
         DAb3lRhRImYw9y/bZTUGon90bhe3mcEqEa16PBl90gyk+W/rbbm/2QgBChish+8+Trx7
         7R4d4vFxkcTY8F5j6YVo/vqhfUaAnj8NcOTAiLxMKfQ20GwdowG1tTpF2TjJMJc/Fyvg
         H7jQ==
X-Gm-Message-State: AO0yUKWScIcfNFhAIJRb9N2bJ89uGviI4Wx6pjdoXVNNl3WYavqr3A6C
        6VOt+hKKP9BQtefugWoVosNBrXh+JLSuwA==
X-Google-Smtp-Source: AK7set+isViHh5qAZns7K3NPtG/U2ufqQGwkH0uWIkhEKR4rgTkTBpbvXLJoy52ernhcZR/6OWG9NQ==
X-Received: by 2002:ac8:5ad0:0:b0:3b6:8ad1:3be9 with SMTP id d16-20020ac85ad0000000b003b68ad13be9mr13526388qtd.32.1674760280255;
        Thu, 26 Jan 2023 11:11:20 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:78c2])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a119300b00706b42c0842sm1401598qkk.49.2023.01.26.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:11:19 -0800 (PST)
Date:   Thu, 26 Jan 2023 13:11:17 -0600
From:   David Vernet <void@manifault.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: Mapping local-storage maps into user space
Message-ID: <Y9LQVU2uz9SzYARP@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

Another proposal from me for LSF/MM/BPF, and the last one for the time
being. I'd like to discuss enabling local-storage maps (e.g.
BPF_MAP_TYPE_TASK_STORAGE and BPF_MAP_TYPE_CGRP_STORAGE) to be r/o
mapped directly into user space. This would allow for quick lookups of
per-object state from user space, similar to how we allow it for
BPF_MAP_TYPE_ARRAY, without having to do something like either of the
following:

- Allocating a statically sized BPF_MAP_TYPE_ARRAY which is >= the # of
  possible local-storage elements, which is likely wasteful in terms of
  memory, and which isn't easy to iterate over.

- Use something like https://docs.kernel.org/bpf/bpf_iterators.html to
  iterate over tasks or cgroups, and collect information for each which
  is then dumped to user space. This would probably work, but it's not
  terribly performant in that it requires copying memory, trapping into
  the kernel, and full iteration even when it's only necessary to look
  up e.g. a single element.

Designing and implementing this would be pretty non-trivial. We'd have
to probably do a few things:

1. Write an allocator that dynamically allocates statically sized
   local-storage entries for local-storage maps, and populates them into
   pages which are mapped into user space.

2. Come up with some idr-like mechanism for mapping a local-storage
   object to an index into the mapping. For example, mapping a task with
   global pid 12345 to BPF_MAP_TYPE_TASK_STORAGE index 5, and providing
   ergonomic and safe ways to update these entries in the kernel and
   communicate them to user space.

3. Related to point 1 above, come up with some way to dynamically extend
   the user space mapping as more local-storage elements are added. We
   could potentially reserve a statically sized VA range and map all
   unused VA pages to the zero page, or instead possibly just leave them
   unmapped until they're actually needed.

There are a lot of open questions, but I think it could be very useful
if we can make it work. Let me know what you all think.

Thanks,
David
