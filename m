Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314991C3F77
	for <lists+bpf@lfdr.de>; Mon,  4 May 2020 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgEDQLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 May 2020 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgEDQLy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 May 2020 12:11:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC8C061A0E
        for <bpf@vger.kernel.org>; Mon,  4 May 2020 09:11:53 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i27so9341885ota.7
        for <bpf@vger.kernel.org>; Mon, 04 May 2020 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4kPeSn25NlA+HZeNESrZ9RJJNptTTgK2m7FcbyAyM9o=;
        b=GaKJBUQYpECYEroiqKk0DcIXgiI2FEq8CiFbHS1EplM0FFi29xiNmb5d/5OVTuUyIR
         KUdL2bk5+/81FJhok0JxzKB5/3AvaQb+Dnjp15TqLhHhuiIbjag+qg1gyAynC4QdxCMK
         mpXNw0CHRtQW/OiN+L9sUhdmGdjWU78FvOpOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4kPeSn25NlA+HZeNESrZ9RJJNptTTgK2m7FcbyAyM9o=;
        b=MrplYmTUyIE5jCMrSpTsNvQ9zbLAzZK3QBzgmrz13OVDsge5JrDgZiRnb2GQhp2nGj
         NGT00JywAIkvVOkhI4dsMsYDpCYjsYQVVMyB5SbLRLk2ObfVBPHBovvhR4vvrVhNqfw6
         mV8m7+nE9jp+fJBWlQb0adBXsQ0obXq/fksbLgJgG/+zCEaBMyZSTZB+xeM6LPBtvjJ7
         pRI76GNV4Blc7orrD1Xmq/0lEPc4HBSdv/JBQB/6cEiD4mY+DK2f6tZV9hx26ZpabDIW
         m2/Cr/LlWykXltp0Ycbq2nnrsCByCSTEcZ1D8wp3kWdIZkLuyePWDKLFH5Ta9GpVeafW
         UhIg==
X-Gm-Message-State: AGi0PuZuhYTIOToUQKE1mEjT/vXv4EX6kR87zOii5SgN/l4ewn5jXRKN
        blf53sejfrapKgRRMXzFy2DF0yM0Jh/NYvdNkT2mPvK6b2FHEw==
X-Google-Smtp-Source: APiQypI3hbiqRluKOYr9dMLn0CYwXS8pSAcNe+j/HzTyTBcvgmRXFfwBqUXyY5ol8WJ5soPBA8R85mjHFVWeS60gqf0=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr13586214otk.147.1588608712881;
 Mon, 04 May 2020 09:11:52 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 4 May 2020 17:11:41 +0100
Message-ID: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
Subject: Checksum behaviour of bpf_redirected packets
To:     bpf <bpf@vger.kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In our TC classifier cls_redirect [1], we use the following sequence
of helper calls to
decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:

  skb_adjust_room(skb, -encap_len,
BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
  bpf_redirect(skb->ifindex, BPF_F_INGRESS)

It seems like some checksums of the inner headers are not validated in
this case.
For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
network stack and elicits a SYN ACK.

Is this known but undocumented behaviour or a bug? In either case, is
there a work
around I'm not aware of?

1: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/test_cls_redirect.c#n370
-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
