Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84DD6A12C4
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBWWXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWWXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:23:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47112F31
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:23:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id fa3-20020a17090af0c300b002377eefb6acso427332pjb.3
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWsi9GZ+eqXDcMAxIJHBRB/n12VJYmwA8U6EK0OzsYs=;
        b=PtBzctIvI34J6AC4yAEIopPChyEhWVVSAlyIWm+ilEfTv3KedsUXEzXZ8e/bX7M+VX
         oSuwFsArW3jy1dvG/jRHF95r4tmSbNCS3q3EtN+SwATSTG9G4eKQepZNn8mLZ0rchJWp
         C7tWVXn/MR3VYNm30YOb9NMzZvoXlwkKtAycOa677TLzOEcnLrZFm7KjAXf7ikDMQjAw
         Kx+uqiUotHJg8mGgfBJRSsLDUmUC/7awK/SMK9yx8rdAZUX6LdCWXnN460n5Tr9u9ITj
         VBB28LHVE36ngMNaBej4TPYSTy1dZJQ5svkDioKKeyh/NnjqS0KQe3UvN4a6NKDZHyLl
         bp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWsi9GZ+eqXDcMAxIJHBRB/n12VJYmwA8U6EK0OzsYs=;
        b=uMOQ7e/xlpeWPYRuLVHfTKKcRK9JGY7Y8f27whcAehddqBgnwdn7bnwAEw+Y2HN3Gg
         jjAAx5VneUjBu62hrEhlZMwrye8wZdoDcTrctWakE7HSS9cTZS+VX8Nj/0PLuGN3LJPm
         +ooLg7TjhlZVZYTEfWlmYvmJtJ6UEyRSTmNjSdhxaBUL7xpQT8eb7SYFiQvuaWFl2CcW
         vNp2s1Xb3ZzpkZ7etf947z314m9aD8aYaqXaZLY5ID3vQmoxcdYOTuKte/tFKF13n8En
         wIBCnXgvRJwBlUCnPs/ty+ZsozluUfVUZfQ2qH1JcGSU2JgRh+iUwwqCGgn+LDzBM+W1
         4KVQ==
X-Gm-Message-State: AO0yUKVInCIE+aaByfuSpKzYmooegW4pqyaFtyQkDcZUZVlc7jyOyxh2
        zCaGoPX1ZGI5odGkz0tLg74VeZk=
X-Google-Smtp-Source: AK7set/j2fAmiK/bDEOt4jJE6MJIxZwM5nmJ3AXjVqgH3wHh+ysuA1q4jond6H3XzNq+DKN5JXETPaM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:3291:b0:19a:9f86:adab with SMTP id
 jh17-20020a170903329100b0019a9f86adabmr2205295plb.7.1677191016243; Thu, 23
 Feb 2023 14:23:36 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:23:34 -0800
Mime-Version: 1.0
Message-ID: <Y/fnZkXQdc8lkP7q@google.com>
Subject: [LSF/MM/BPF TOPIC] XDP metadata for TX
From:   Stanislav Fomichev <sdf@google.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'd like to discuss a potential follow up for the previous "XDP RX
metadata" series [0].

Now that we can access (a subset of) packet metadata at RX, I'd like to
explore the options where we can export some of that metadata on TX. And
also whether it might be possible to access some of the TX completion
metadata (things like TX timestamp).

I'm currently trying to understand whether the same approach I've used
on RX could work at TX. By May I plan to have a bunch of options laid
out (currently considering XSK tx/compl programs and XDP tx/compl
programs) so we have something to discuss.

I'd like to some more input on whether applying the same idea on TX
makes sense or not and whether there are any sensible alternatives.
(IIRC, there was an attempt to do XDP on egress that went nowhere).

0: https://lore.kernel.org/bpf/20230119221536.3349901-1-sdf@google.com/
